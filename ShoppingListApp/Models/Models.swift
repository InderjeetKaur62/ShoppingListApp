//
//  Models.swift
//  ShoppingListApp
//
//  Created by Christian Do on 2/23/25.
//

// MARK: - Data Models
import Foundation
import UIKit
// Tax group definitions with associated tax percentages.
enum TaxGroup: String {
    case standard   // Standard 13% HST for taxable goods
    case exempt     // Exempt (0%) tax
    case reduced8   // Reduced rate 8%
    case reduced5   // Reduced rate 5%
    
    var rate: Double {
        switch self {
        case .standard:
            return 0.13
        case .exempt:
            return 0.0
        case .reduced8:
            return 0.08
        case .reduced5:
            return 0.05
        }
    }
}

// Model representing a shopping item.
struct ShoppingItem: Hashable {
    let name: String
    let price: Double
    let imageName: String
    let taxGroup: TaxGroup
    let category: String
}

// Model representing a group of shopping items.
struct ShoppingGroup {
    let name: String
    var items: [ShoppingItem] // Change `let` to `var` to allow modification
    let iconName: String  // New property for the group icon
    var isExpanded: Bool = false  // Default collapsed

    var icon: UIImage? {
        return UIImage(named: iconName)
    }
}


