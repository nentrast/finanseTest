//
//  TableViewContrller.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol TableViewContrllerDelegate: class {
    func tableView(_ tableView: UITableView, didSelect model: Codable?, indexPath: IndexPath)
}

protocol TableViewCompatible {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

class TableViewContrller<C: UITableViewCell>: UITableViewController {
    
    private var cellTypes: [C.Type] = []
    
    var model: SectionControllerModel?  {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.tableView.reloadData()
            })
        }
    }
    
    weak var tableDelegate: TableViewContrllerDelegate?
        
    init(cellType: C.Type...) {
        cellTypes = cellType
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cellTypes.forEach({
            let name = String(describing: $0)
            let nib = UINib.init(nibName: name, bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: name)
        })
        tableView.dataSource = self
    }
    
    func update(_ model: SectionControllerModel) {
        self.model = model
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.rowsCount(in: section) ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sectionCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.title(for: section) 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = model?.item(at: indexPath.row, section: indexPath.section) else {
            return
        }
        tableDelegate?.tableView(tableView, didSelect: item, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = model?.tableView(tableView, cellForRowAt: indexPath) else {
            fatalError("Cant unwrap")
        }
        return cell
    }
}
