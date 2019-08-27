//
//  Active.swift
//  TestFinance
//
//  Created by Alexandr Lobanov on 8/26/19.
//  Copyright © 2019 Alexandr Lobanov. All rights reserved.
//

import UIKit

struct ActiveRoot: Codable {
    let abriviature: String
    let active: Active
}

extension ActiveRoot: TableViewCompatible {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivesTableViewCell", for: indexPath) as? ActivesTableViewCell else {
            fatalError()
        }
        cell.configure(model: self)
        return cell
    }
}

struct Active: Codable {
    
    enum CodingKeys: String, CodingKey {
        case ticker = "Ticker"
        case price = "Price"
        case changes = "Changes"
        case changesPercents = "ChangesPerc"
        case name = "companyName"
    }

    var ticker: String
    var price: String
    var changes: Double
    var changesPercents: String
    var name: String
}

