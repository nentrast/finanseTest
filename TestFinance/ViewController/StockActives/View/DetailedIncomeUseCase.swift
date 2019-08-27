//
//  DetailedIncomeUseCase.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

typealias IncomeDictionaty = [String: [String: [String: String]]]

protocol DetailedIncomeUseCaseProtocol: class {
    func getIncome(for name: String)
}

class DetailedIncomeUseCase: DetailedIncomeUseCaseProtocol {
    var network: NetworkProvider<StockRouter>?
    var presenter: DetailedIncomePresenterOutput?
    
    func getIncome(for name: String) {
        network?.request(service: .income(active: name), decodeType: IncomeDictionaty.self, completion: { (result) in
            switch result {
            case .failure(let error):
                self.presenter?.handleError(error)
            case .success(let resultValue):
                guard let result = resultValue.map({ (key, sectionDataDictionary) -> IncomeRoot in
                   let incomeSectionData = sectionDataDictionary.map({ (key, valueData) -> IncomeSectionData in
                     let incomeValueData = valueData.map({ (date, value) -> IncomeValueData in
                            return  IncomeValueData(date: date, value: value)
                        })
                       return IncomeSectionData(name: key, value: incomeValueData)
                    })
                    return IncomeRoot(abreviature: key, items: incomeSectionData)
                }).first else {
                    return
                }
                let sectionModel = IcomeSectionController.init(model: result)
                self.presenter?.showIcnome(model: sectionModel)
            }
        })
    }
}
