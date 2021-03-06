//
//  Utils.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 06.03.2021.
//

import Foundation

func isValidAmount(_ str: String) -> Bool {
    if str == "" {
        return true
    }
    let doubleVal = Double(str)
    if doubleVal != nil && doubleVal! <= 1_000_000_000 {
        let integerString = String(Int(doubleVal!))
        let doubleString = String(doubleVal!)
        let decimalCount = doubleString.count - integerString.count - 1
        if decimalCount <= 6 {
            return true
        }
    }
    return false
}
