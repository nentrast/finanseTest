//
//  StockActivePresenter.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol StockActivePresenterInput: class {
    func didSelect(model: ActiveRoot)
    func getStockActives()
}

protocol StockActivePresenterOutput: class {
    func showActives(_ model: SectionControllerModel)
    func haandleError(_ error: Error?)
}

class StockActivePresenter: NSObject, StockActivePresenterInput {
  
    weak var view: StockActiveViewControllerOutput?
    var useCase: StockUseCase?
    
    func didSelect(model: ActiveRoot) {
        view?.showDetailedIncome(for: model)
    }
    
    func getStockActives() {
        useCase?.getStokcActives()
    }
}

extension StockActivePresenter: StockActivePresenterOutput {
    
    func showActives(_ model: SectionControllerModel) {
        view?.showModels(model)
    }
    
    func haandleError(_ error: Error?) {
        view?.showError(error)
    }
}
