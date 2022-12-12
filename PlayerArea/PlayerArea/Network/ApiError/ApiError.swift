//
//  ApiError.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

enum ApiError: Error {
    case unknownError
    case connectionError
    case notFoundError
    case serverError
    case timeOut
    case badRequest
    case decodeError
}

extension ApiError: CustomStringConvertible {
    public var description: String {
        switch self {
            
        case .unknownError:
            return "Unknown Error!"
        case .connectionError:
            return "Connnection Error!"
        case .notFoundError:
            return "Not Found Error!"
        case .serverError:
            return "Server Error!"
        case .timeOut:
            return "Time Out!"
        case .badRequest:
            return "Bad Request!"
        case .decodeError:
            return "Decode Error!"
        }
    }
}
