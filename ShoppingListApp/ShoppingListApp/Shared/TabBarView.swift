//
//  TabBarView.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("HOME")
                }

            ItemListView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Item")
                }

            CategoryListView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Categories")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
        }
    }
}

