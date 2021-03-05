//
//  TransactionsViewModel.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import Foundation

class TransactionsViewModel {
    weak var coordinator: TransactionsCoordinator?
    
    func goToAddTransaction() {
        coordinator?.addTransaction()
    }
}
