//
//  StockRouter.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import Alamofire

enum StockRouter: NetwotrkRouter {
    case actives
    case income(active: String)
    
    var baseURL: String {
        return "https://financialmodelingprep.com/api/"
    }
    
    var path: String {
        switch self {
        case .actives:
            return "stock/actives"
        case .income(active: let name):
            return "financials/income-statement/\(name)"
        }
    }
    var parameters: [String : Any]? {
        return ["datatype" : "json"]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
