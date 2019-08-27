//
//  JSONDecoder.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import Alamofire

enum SerializationError: Error {
    case missingKey
    case wrongDecodeObject
}

class JSONObjectDecoder {
    static func decode<U>(type: U.Type, data: Data, compeltion: @escaping (Result<U>) -> Void) where U: Decodable {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(type, from: data)
            
            compeltion(Result.success(object))
        } catch let error {
            compeltion(Result.failure(error))
        }
    }
}

