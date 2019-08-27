//
//  NetworkLayer.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 7/24/19.
//  Copyright © 2019 DB2. All rights reserved.
//

import Alamofire

enum NetworkError: Error {
    case unauthorized
    case notFound
    case deserializer(SerializationError)
    case serverUnavailable
    case error(Error)
}


class NetworkProvider<T: NetwotrkRouter> {
    
    deinit {
        print("Deinit NetworkProvider")
    }
    
    func request<U>(service: T, decodeType: U.Type, completion: @escaping ((Result<U>) -> Void)) where U: Decodable {
        Alamofire.request(service).responseData { (dataResponse) in
            //MARK: add some caching if failed result
            switch dataResponse.result {
            case .success(let data):
                JSONObjectDecoder.decode(type: decodeType, data: data, compeltion: completion)
            case .failure(let error):
                completion(Result.failure(NetworkError.error(error)))
            }
        }
    }
}

