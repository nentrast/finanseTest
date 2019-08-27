//
//  UIViewContrller+Extension.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    func embedController(_ vc: UIViewController, containerView: UIView) {
        guard let vcView = vc.view else { return }
        
        addChild(vc)
        containerView.addSubview(vcView)
        
        vcView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        vc.didMove(toParent: self)
    }
}
