//
//  StockActiveViewController.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol StockActiveViewControllerOutput: class  {
    func showModels(_ model: SectionControllerModel)
    func showError(_ error: Error?)
}

class StockActiveViewController: UIViewController, StockActiveViewControllerOutput, TableViewContrllerDelegate {
    
    @IBOutlet weak var tableContrinerView: UIView!
    
    var presenter: StockActivePresenterInput?
    private var tableViewController: TableViewContrller<ActivesTableViewCell>?
    
    init() {
        super.init(nibName: "StockActiveViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableViewController = TableViewContrller.init(cellType: ActivesTableViewCell.self)
        tableViewController?.tableDelegate = self
        guard let tableViewContrller = tableViewController else {
            return
        }
        embedController(tableViewContrller, containerView: tableContrinerView)
        presenter?.getStockActives()
    }
  
    func showModels(_ model: SectionControllerModel) {
        tableViewController?.update(model)
    }
    
    func showError(_ error: Error?) {
        // MARK: show error alert
    }
    
    func tableView(_ tableView: UITableView, didSelect model: Codable?, indexPath: IndexPath) {
        guard let model = model as? ActiveRoot else {
                return
        }
        presenter?.didSelect(model: model)
    }
}
