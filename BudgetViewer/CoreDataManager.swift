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
    
}
