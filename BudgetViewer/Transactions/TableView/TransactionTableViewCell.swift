//
//  TransactionTableViewCell.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 06.03.2021.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, ReuseIdentifiable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
