//
//  SceneFactory.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

class SceneFactory {
    static func stockActivesScene(flowController: AppFlowController) -> UIViewController {
        let view = StockActiveViewController()
        let presenter = StockActivePresenter()
        let useCase = StockUseCase()
        let network = NetworkProvider<StockRouter>()
        
        view.presenter = presenter
        presenter.useCase = useCase
        presenter.view = view
        useCase.presenter = presenter
        useCase.network = network
        presenter.controller = flowController

        return view
    }
    
    static func incomeScene(_ model: ActiveRoot) -> UIViewController {
        let view = DetailedIncomeViewController.init(active: model)
        let presenter = DetailedIncomePresenter()
        let usecase = DetailedIncomeUseCase()
        let newtwork = NetworkProvider<StockRouter>()
        
        view.presenter = presenter
        presenter.usecase = usecase
        presenter.view = view
        usecase.presenter = presenter
        usecase.network = newtwork
        
        return view
    }
}
