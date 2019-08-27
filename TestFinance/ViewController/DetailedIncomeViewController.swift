//
//  DetailedIncomeViewController.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol DetailedIncomeViewControllerInput: class {
    func update(for data: SectionControllerModel)
}

class DetailedIncomeViewController: UIViewController, DetailedIncomeViewControllerInput {
    @IBOutlet weak var tableContainerView: UIView!
    
    private var model: ActiveRoot?
    var presenter: DetailedIncomePresenterInput?
    
    private var tableViewController: TableViewContrller<IncomeTableViewCell>?
    
    init(active: ActiveRoot) {
        model = active
        super.init(nibName: "DetailedIncomeViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = model?.abriviature
        tableViewController = TableViewContrller(cellType: IncomeTableViewCell.self)
        tableViewController?.tableDelegate = self
        tableViewController?.tableView.allowsSelection = false
        guard let tableVC = tableViewController else {
            return
        }
        
        embedController(tableVC, containerView: tableContainerView)
        presenter?.getIcome(for: model?.abriviature ?? "")
    }
    
    func update(for data: SectionControllerModel) {
        tableViewController?.update(data)
    }
}

extension  DetailedIncomeViewController: TableViewContrllerDelegate {
    func tableView(_ tableView: UITableView, didSelect model: Codable?, indexPath: IndexPath) {
        print("Selected model: \(model)")
    }
}
