//
//  DetailedIncomePresenter.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol DetailedIncomePresenterInput: class {
    func getIcome(for name: String)
}

protocol DetailedIncomePresenterOutput: class {
    func showIcnome(model: SectionControllerModel)
    func handleError(_ error: Error)
}

class DetailedIncomePresenter: DetailedIncomePresenterInput,  DetailedIncomePresenterOutput {
    
    weak var view: DetailedIncomeViewControllerInput?
    var usecase: DetailedIncomeUseCaseProtocol?
    
    func getIcome(for name: String) {
        usecase?.getIncome(for: name)
    }

    func showIcnome(model: SectionControllerModel) {
        view?.update(for: model)
    }
    
    func handleError(_ error: Error) {
        
    }
}
