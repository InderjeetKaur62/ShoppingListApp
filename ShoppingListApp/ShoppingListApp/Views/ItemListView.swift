//
//  ItemListView.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    @State private var itemName = ""
    @State private var quantityText = ""
    @State private var selectedCategory: Category?

    // Store price inputs per item
    @State private var itemPrices: [UUID: String] = [:]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Add New Item")) {
                    TextField("Item Name", text: $itemName)
                    TextField("Quantity", text: $quantityText)
                        .keyboardType(.numberPad)

                    Picker("Category", selection: $selectedCategory) {
                        ForEach(viewModel.categories) { category in
                            Text(category.name).tag(Optional(category))
                        }
                    }

                    Button("Add Item") {
                        addItem()
                    }
                    .disabled(itemName.isEmpty || quantityText.isEmpty || selectedCategory == nil)
                }

                Section(header: Text("Available Items")) {
                    ForEach(viewModel.items) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(item.name) - Qty: \(item.quantity)")
                            Text("Category: \(item.category.name)")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            HStack {
                                TextField("Enter Price", text: Binding(
                                    get: { itemPrices[item.id, default: ""] },
                                    set: { itemPrices[item.id] = $0 }
                                ))
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                                Button("Add to Cart") {
                                    addToCart(item)
                                }
                                .disabled(Double(itemPrices[item.id] ?? "") == nil)
                                .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("LIST OF ITEMS")
        }
    }

    func addItem() {
        guard let quantity = Int(quantityText), let category = selectedCategory else { return }
        viewModel.addItem(name: itemName, quantity: quantity, category: category)
        itemName = ""
        quantityText = ""
        selectedCategory = nil
    }

    func addToCart(_ item: Item) {
        guard let priceString = itemPrices[item.id], let price = Double(priceString) else { return }
        viewModel.addToCart(item: item, price: price, quantity: item.quantity)
        itemPrices[item.id] = "" // clear field
    }
}
