//
//  Income.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

struct IncomeValueData: Codable {
    let date: String
    let value: String
}

struct IncomeSectionData: Codable {
    let name: String
    let value: [IncomeValueData]
    
}

struct IncomeRoot: Codable, TableViewCompatible {
    let abreviature: String
    let items: [IncomeSectionData]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as? IncomeTableViewCell else {
            fatalError()
        }
        let model = items[indexPath.section].value[indexPath.row]
        cell.configure(model)
        return cell
    }
}
