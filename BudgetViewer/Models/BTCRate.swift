//
//  BTCRate.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import Foundation

struct BTCRate: Codable {
    
    var bpi: BPI?
    
    enum CodingKeys: String, CodingKey {
        case bpi = "bpi"
    }
    
    struct BPI: Codable {
        let usd: USD?
        
        struct USD: Codable {
            var rate: String?
            
            enum CodingKeys: String, CodingKey {
                case rate = "rate"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case usd = "USD"
        }
    }
    
    var rate: Double {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        return formatter.number(from: bpi?.usd?.rate?.replacingOccurrences(of: ",", with: "") ?? "0")?.doubleValue ?? 0
    }
}
