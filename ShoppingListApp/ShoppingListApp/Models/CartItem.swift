//
//  CartItem.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//
import Foundation

struct CartItem: Identifiable, Hashable {
    let id = UUID()
    var item: Item
    var price: Double
    var quantity: Int
}

