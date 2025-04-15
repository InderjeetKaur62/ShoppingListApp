//
//  CartView.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Button("Back") {
                        // Add back navigation if needed
                    }
                    .foregroundColor(.blue)
                    Spacer()
                    Button("Add Item") {
                        // Navigate to item screen if needed
                    }
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)

                Text("CART")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                ScrollView {
                    ForEach(groupCartByCategory(), id: \.0.id) { (category, items) in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Image(systemName: getIcon(for: category.name))
                                Text(category.name)
                                    .font(.headline)
                            }

                            ForEach(items) { cartItem in
                                HStack {
                                    Text(cartItem.item.name)
                                    Spacer()
                                    Text(String(format: "$%.2f", cartItem.price))
                                    Stepper("", value: .constant(cartItem.quantity))
                                    Image(systemName: "plus")
                                        .foregroundColor(.green)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                    }
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Subtotal: \(String(format: "$%.2f", viewModel.subtotal))")
                    Text("Tax: \(String(format: "$%.2f", viewModel.tax))")
                    Text("Total: \(String(format: "$%.2f", viewModel.total))")
                        .bold()
                }
                .padding()
            }
        }
    }

    func groupCartByCategory() -> [(Category, [CartItem])] {
        Dictionary(grouping: viewModel.cartItems, by: { $0.item.category }).map { ($0.key, $0.value) }
    }

    func getIcon(for category: String) -> String {
        switch category {
        case "Apple": return "applelogo"
        case "Laptop": return "laptopcomputer"
        case "Health": return "heart.fill"
        default: return "cart.fill"
        }
    }
}
