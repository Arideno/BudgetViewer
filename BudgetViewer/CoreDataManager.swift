//
//  CoreDataManager.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BudgetViewer")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createAccountIfNotExist() {
        if getMainAccount() != nil {
            return
        }
        
        let account = Account(context: context)
        account.balance = 0
        account.name = "Main Account"
        
        saveContext()
    }
    
    func getMainAccount() -> Account? {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        
        if let results = try? context.fetch(request) {
            if let account = results.first {
                return account
            }
        }
        
        return nil
    }
    
    func increaseBalance(account: Account, amount: Double) {
        account.balance = account.balance?.adding(NSDecimalNumber(value: amount))
        saveContext()
    }
    
    func createTransaction(amount: Double, category: String) {
        let transaction = Transaction(context: context)
        transaction.account = getMainAccount()
        transaction.category = category
        transaction.amount = NSDecimalNumber(value: amount)
        transaction.uuid = UUID()
        transaction.date = Date()
        
        transaction.account?.balance = transaction.account?.balance?.subtracting(transaction.amount ?? 0)
        
        saveContext()
    }
    
    func getTransactionsCount() -> Int {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        if let count = try? context.count(for: request) {
            return count
        }
        
        return 0
    }
    
    func getTransactions(limit: Int, page: Int) -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.sortDescriptors = [.init(key: "date", ascending: false)]
        request.fetchLimit = limit
        request.fetchOffset = (page - 1) * limit
        
        if let transactions = try? context.fetch(request) {
            return transactions
        }
        
        return []
    }
    
}
