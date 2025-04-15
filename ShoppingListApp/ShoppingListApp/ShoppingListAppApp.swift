//
//  ShoppingListAppApp.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//
import SwiftUI

@main
struct ShoppingListApp: App {
    @StateObject private var viewModel = ShoppingViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(viewModel)
        }
    }
}
