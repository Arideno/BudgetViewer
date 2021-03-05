//
//  Account+CoreDataProperties.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var balance: NSDecimalNumber?
    @NSManaged public var name: String?

}

extension Account : Identifiable {

}
