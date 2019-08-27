//
//  AppFlowController.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/27/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol AppFlowControllerProtocol: class {
    var childFlow: AppFlowControllerProtocol? { get set }
    var parrentFlow: AppFlowControllerProtocol? { get set }
    
    var currentViewController: UIViewController? { get set }
    
    init(nc: UIViewController)
    func start()
    func showChildFlow(_ flow: AppFlowControllerProtocol)
    func changeFlow(_ flow: AppFlowControllerProtocol)
    func dismiss(_ completion: (() -> Void)?)
    func presentModaly(_ flow: AppFlowControllerProtocol)
    func presentModaly(_ vc: UIViewController)
    func popViewController(barHidedn: Bool, animate: Bool)
}

extension AppFlowControllerProtocol {
    
    func changeFlow(_ flow: AppFlowControllerProtocol) {
        if parrentFlow == nil {
            showChildFlow(flow)
        }
        parrentFlow?.changeFlow(flow)
    }
    
    func showChildFlow(_ flow: AppFlowControllerProtocol) {
        childFlow = flow
        childFlow?.parrentFlow = self
        childFlow?.start()
    }
    
    func dismiss(_ completion: (() -> Void)?) {
        parrentFlow?.childFlow = nil
        parrentFlow = nil
        currentViewController?.dismiss(animated: true, completion: completion)
        currentViewController = nil
    }
    
    func presentModaly(_ flow: AppFlowControllerProtocol) {
        childFlow = flow
        flow.parrentFlow = self
        flow.start()
        guard let vc = flow.currentViewController else { return }
        
        currentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func presentModaly(_ vc: UIViewController) {
        guard let currentVC = currentViewController else {
            fatalError()
        }
        currentVC.present(vc, animated: true, completion: nil)
    }
    
    func popViewController(barHidedn: Bool = true, animate: Bool = true) {
        if let parrent = parrentFlow, let currentNC = currentViewController as? UINavigationController {
            parrent.childFlow = nil
            childFlow = nil
            currentNC.setNavigationBarHidden(barHidedn, animated: animate)
            currentNC.popViewController(animated: animate)
        } else {
            fatalError("What are doing man?!?!?! You cant do this because your currentViewController isnt UINavigationController")
        }
    }
}

class AppFlowController: AppFlowControllerProtocol {
    
    var currentViewController: UIViewController?
    let navigationVC: UINavigationController
    
    var childFlow: AppFlowControllerProtocol?
    weak var parrentFlow: AppFlowControllerProtocol?
    

    init(nc: UINavigationController) {
        navigationVC = nc
    }
    
    required init(nc: UIViewController) {
        navigationVC = UINavigationController()
    }
    
    func start() {
        showStock()
    }
    
    func showStock() {
        let scene = SceneFactory.stockActivesScene(flowController: self)
        navigationVC.setViewControllers([scene], animated: true)
    }

    func showDetailedIncome(_ model: ActiveRoot) {
        let scene = SceneFactory.incomeScene(model)
        navigationVC.pushViewController(scene, animated: true)
    }
}

