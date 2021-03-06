//
//  AddTransactionViewModel.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import Foundation

class AddTransactionViewModel {
    weak var coordinator: AddTransactionCoordinator?
    
    var amount: Double
    var category: String
    
    var transactionCreated: (() -> ())?
    
    init() {
        category = categories[0]
        amount = 0
    }
    
    func pickCategory(_ category: String) {
        self.category = category
    }
    
    func changeAmount(_ amount: Double) {
        self.amount = amount
    }
    
    func createTransaction() {
        if amount == 0 || category.isEmpty { return }
        CoreDataManager.shared.createTransaction(amount: amount, category: category)
        transactionCreated?()
    }
}
