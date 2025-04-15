//
//  HomeView.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("SHOPPING LIST")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.top)

                List {
                    // Convert dictionary to array of tuples
                    ForEach(getGroupedItems(), id: \.0.id) { (category, items) in
                        Section {
                            HStack {
                                Image(systemName: getIcon(for: category.name))
                                    .resizable()
                                    .frame(width: 24, height: 24)

                                VStack(alignment: .leading) {
                                    Text(category.name)
                                        .font(.headline)
                                    Text("Items: \(items.count)")
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Image(systemName: "ellipsis")
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
    }

    func getGroupedItems() -> [(Category, [Item])] {
        // Return as array of tuples instead of Dictionary
        Dictionary(grouping: viewModel.items, by: { $0.category }).map { ($0.key, $0.value) }
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
