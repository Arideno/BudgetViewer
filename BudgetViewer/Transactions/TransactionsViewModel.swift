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
    var rateChanged: ((String) -> ())?
    var showBalanceIncrease: (() -> ())?
    
    var updateRateTimer: Timer?
    
    var account: Account!
    
    init() {
        requestBTCRate()
        updateRateTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(requestBTCRate), userInfo: nil, repeats: true)
    }
    
    deinit {
        updateRateTimer?.invalidate()
    }
    
    func loadData() {
        account = CoreDataManager.shared.getMainAccount()
        accountChanged?()
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
                    self.rateChanged?("\(btcRate.rate)")
                }
            }
            task.resume()
        }
    }
}
