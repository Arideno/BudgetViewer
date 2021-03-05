//
//  Transaction+CoreDataProperties.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var account: Account?

}

extension Transaction : Identifiable {

}
