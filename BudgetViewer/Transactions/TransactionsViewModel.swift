//
//  TransactionsViewModel.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import Foundation

class TransactionsViewModel {
    weak var coordinator: TransactionsCoordinator?
    
    var accountChanged: (() -> ())?
    var showBalanceIncrease: (() -> ())?
    
    var account: Account!
    
    func loadData() {
        account = CoreDataManager.shared.getMainAccount()
        accountChanged?()
    }
    
    func increaseBalance(amount: Double) {
        CoreDataManager.shared.increaseBalance(account: account, amount: amount)
        accountChanged?()
    }
    
    func goToIcreaseBalance() {
        showBalanceIncrease?()
    }
    
    func goToAddTransaction() {
        coordinator?.addTransaction()
    }
}
