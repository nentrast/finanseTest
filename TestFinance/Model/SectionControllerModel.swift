//
//  SectionControllerModel.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/27/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

protocol SectionControllerModel: TableViewCompatible {
    func sectionCount() -> Int
    func rowsCount(in section: Int) -> Int
    func title(for section: Int) -> String?
    func item(at index: Int, section: Int) -> Codable?
}

extension SectionControllerModel {
    func title(for section: Int) -> String? {
        return nil
    }
}

class ActiveSectionController: SectionControllerModel, TableViewCompatible {
    
    init(model: [ActiveRoot]) {
        self.model = model
    }
    
    var model: [ActiveRoot] = []
    
    func sectionCount() -> Int {
        return 1
    }
    
    func rowsCount(in section: Int) -> Int {
        return model.count
    }
    
    func item(at index: Int, section: Int) -> Codable? {
        return model[index]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivesTableViewCell", for: indexPath) as? ActivesTableViewCell else {
            fatalError()
        }
        guard let model = item(at: indexPath.row, section: indexPath.section) as? ActiveRoot else {
            fatalError()
        }
        cell.configure(model: model)
        return cell
    }
    
}

class IcomeSectionController: SectionControllerModel, TableViewCompatible {
    var model: IncomeRoot
    
    init(model: IncomeRoot) {
        self.model = model
    }
    
    func sectionCount() -> Int {
        return model.items.count
    }
    
    func rowsCount(in section: Int) -> Int {
        return model.items[section].value.count
    }
    
    func item(at index: Int, section: Int) -> Codable? {
        return model.items[section].value[index]
    }
    
    func title(for section: Int) -> String? {
        return model.items[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell",
                                                       for: indexPath) as? IncomeTableViewCell else {
            fatalError()
        }
        guard let model = item(at: indexPath.row, section: indexPath.section) as? IncomeValueData else {
            fatalError("Cant unwrap")
        }
        cell.configure(model)
        return cell
    }
}
