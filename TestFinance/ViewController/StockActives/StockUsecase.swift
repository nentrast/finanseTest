//
//  StockUsecase.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import Alamofire

protocol StocUseCaseInput: class {
    func getStokcActives()
}

class StockUseCase: StocUseCaseInput {
    
    var network:  NetworkProvider<StockRouter>?
    weak var presenter: StockActivePresenterOutput?
    
    func getStokcActives() {
        network?.request(service: .actives, decodeType: [String: Active].self, completion: { (result) in
            switch result {
            case .success(let value):
                let objects = value.map({ (key, vlaue) -> ActiveRoot in
                    return ActiveRoot(abriviature: key, active: vlaue)
                })
                let sectionController =  ActiveSectionController.init(model: objects)
                self.presenter?.showActives(sectionController)
            case .failure(let error):
                self.presenter?.haandleError(error)
            }
        })
    }
}
