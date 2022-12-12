//
//  Requestable.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 12.12.2022.
//

import Foundation

protocol Requestable {
    var baseURL: String? { get }
    var paths : [String]? { get }
    var parameters : [String : Any]? { get }
    var headers : [String : String]? { get }
    var method : RequestMethod? { get }
    var body : [String : Any]? { get }
    
    func generateRequest() -> URLRequest?
    mutating func prepareRequest()
}

extension Requestable {
    
    var baseURL: String? {
        return ApiConstant.baseUrl.rawValue
    }
    var method: RequestMethod? {
        return .get
    }
    var body: [String : Any]? {
        return nil
    }
    var parameters: [String: Any]? {
        return [
            "key": "6b4fab3e88ec48aab19933b2c153c7c9"
        ]
    }
    var headers: [String : String]? {
        return nil
    }
    
    mutating func prepareRequest() { }
}
