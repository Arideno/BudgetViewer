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
    var transactionsChanged: (() -> ())?
    var rateChanged: ((String) -> ())?
    var showBalanceIncrease: (() -> ())?
    
    var updateRateTimer: Timer?
    
    var account: Account!
    var transactions = [Transaction]()
    var transactionSections = [DateComponents]()
    
    init() {
        requestBTCRate()
        updateRateTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(requestBTCRate), userInfo: nil, repeats: true)
    }
    
    deinit {
        updateRateTimer?.invalidate()
    }
    
    func loadAccount() {
        account = CoreDataManager.shared.getMainAccount()
        accountChanged?()
    }
    
    func loadTransactions() {
        transactions = CoreDataManager.shared.getAllTransactions()
        let dates = transactions.map({ $0.date ?? Date() })
        let components = Set(dates.map({ Calendar.current.dateComponents([.day, .month, .year], from: $0) })).sorted(by: {
            Calendar.current.date(from: $0) ?? Date.distantFuture > Calendar.current.date(from: $1) ?? Date.distantFuture
        })
        transactionSections = Array(components)
        accountChanged?()
        transactionsChanged?()
    }
    
    func increaseBalance(amount: Double) {
        if amount <= 0 {
            return
        }
        CoreDataManager.shared.increaseBalance(account: account, amount: amount)
        accountChanged?()
    }
    
    func goToIcreaseBalance() {
        showBalanceIncrease?()
    }
    
    func goToAddTransaction() {
        coordinator?.addTransaction()
    }
    
    func getTransactionsForDateComponents(_ components: DateComponents) -> [Transaction] {
        return transactions.filter({ Calendar.current.dateComponents([.day, .month, .year], from: $0.date ?? Date()) == components })
    }
    
    @objc private func requestBTCRate() {
        if let url = URL(string: btcRateUrl) {
            let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.rateChanged?("No data")
                    }
                    return
                }
                guard let btcRate = try? JSONDecoder().decode(BTCRate.self, from: data) else {
                    DispatchQueue.main.async {
                        self.rateChanged?("No data")
                    }
                    return
                }
                DispatchQueue.main.async {
                    if btcRate.rate == -1 {
                        self.rateChanged?("No data")
                    } else {
                        self.rateChanged?("\(btcRate.rate)")
                    }
                }
            }
            task.resume()
        }
    }
}
