//
//  UrlSessionManager.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

protocol Networking {
    func request<T: Codable>(request: Requestable, completion: @escaping (Result<T, ApiError>) -> Void)
}

final class UrlSessionManager: Networking {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request<T>(request: Requestable, completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let generateRequest = request.generateRequest()
        else {
            completion(.failure(.badRequest))
            return
        }
        let task = session.dataTask(with: generateRequest) { data, response, error in
            if error != nil || data == nil {
                completion(.failure(.connectionError))
            }
            if let apiError = self.returnResponseErrorIfNeeded(response: response) {
                completion(.failure(apiError))
            }
            
            guard let data = data else { return }
            
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
}

extension UrlSessionManager {
    func returnError(with responseCode: Int) -> ApiError {
        switch responseCode {
        case 400:
            return .notFoundError
        case 403:
            return .unknownError
        case 408:
            return .timeOut
        case 500:
            return .serverError
        default:
            return .unknownError
        }
    }
    
    func returnResponseErrorIfNeeded(response: URLResponse?) -> ApiError? {
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            return returnError(with: httpResponse.statusCode)
        }
        return nil
    }
}
