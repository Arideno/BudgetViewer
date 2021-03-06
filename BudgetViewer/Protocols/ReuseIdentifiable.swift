//
//  ReuseIdentifiable.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 06.03.2021.
//

import Foundation

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
