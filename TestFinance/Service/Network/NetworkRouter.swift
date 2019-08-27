//
//  NetworkRouter.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import Alamofire

protocol NetwotrkRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension NetwotrkRouter {
    //MARK: Here you can set default value of baseURL
    var baseURL: String {
        return ""
    }
    
    //MARK: Default authorization
    var headers: HTTPHeaders? {
        return nil
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method, headers: headers)
        switch method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .post:
            urlRequest = try JSONEncoding().encode(urlRequest, with: parameters)
            break
        default:
            return URLRequest.init(url: url)
        }
        
        return urlRequest
    }
}
