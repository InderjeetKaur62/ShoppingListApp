//
//  Item.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var quantity: Int
    var category: Category
}
