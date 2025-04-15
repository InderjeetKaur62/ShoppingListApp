//
//  ShoppingViewModel.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//

import Foundation

class ShoppingViewModel: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Supermarket"),
        Category(name: "Pharmacy"),
        Category(name: "Entertainment")
    ]
    
    @Published var items: [Item] = []
    
    @Published var cartItems: [CartItem] = []
    
    func addItem(name: String, quantity: Int, category: Category) {
        let newItem = Item(name: name, quantity: quantity, category: category)
        items.append(newItem)
    }
    
    func addToCart(item: Item, price: Double, quantity: Int) {
        let cartItem = CartItem(item: item, price: price, quantity: quantity)
        cartItems.append(cartItem)
    }
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var tax: Double {
        subtotal * 0.13 // 13% tax
    }
    
    var total: Double {
        subtotal + tax
    }
}
