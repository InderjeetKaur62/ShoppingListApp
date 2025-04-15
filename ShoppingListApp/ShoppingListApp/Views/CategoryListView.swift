//
//  CategoryListView.swift
//  ShoppingListApp
//
//  Created by Inderjeet Kaur on 2025-04-14.
//
import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel

    @State private var newCategoryName = ""
    @State private var editingCategory: Category?
    @State private var editedName = ""
    @State private var showEditAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("LIST OF CATEGORIES")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.top)

                Form {
                    Section(header: Text("Add New Category")) {
                        TextField("Category Name", text: $newCategoryName)
                        Button("Add Category") {
                            addCategory()
                        }
                        .disabled(newCategoryName.isEmpty)
                    }

                    Section(header: Text("Existing Categories")) {
                        ForEach(viewModel.categories) { category in
                            HStack {
                                Text(category.name)
                                    .font(.body)
                                Spacer()

                                // FIX: EDIT BUTTON goes first
                                Button(action: {
                                    editingCategory = category
                                    editedName = category.name
                                    showEditAlert = true
                                }) {
                                    Image(systemName: "pencil.circle")
                                        .foregroundColor(.blue)
                                        .imageScale(.large)
                                }

                                // FIX: DELETE BUTTON goes second
                                Button(action: {
                                    deleteCategory(category)
                                }) {
                                    Image(systemName: "trash.circle")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .alert("Edit Category", isPresented: $showEditAlert, actions: {
                TextField("New Name", text: $editedName)
                Button("Save") {
                    if let index = viewModel.categories.firstIndex(where: { $0.id == editingCategory?.id }) {
                        viewModel.categories[index].name = editedName

                        // Update name in related items & cart
                        for i in 0..<viewModel.items.count {
                            if viewModel.items[i].category.id == editingCategory?.id {
                                viewModel.items[i].category.name = editedName
                            }
                        }
                        for i in 0..<viewModel.cartItems.count {
                            if viewModel.cartItems[i].item.category.id == editingCategory?.id {
                                viewModel.cartItems[i].item.category.name = editedName
                            }
                        }
                    }
                    editedName = ""
                    editingCategory = nil
                }
                Button("Cancel", role: .cancel) {
                    editedName = ""
                    editingCategory = nil
                }
            })
        }
    }

    func addCategory() {
        let newCategory = Category(name: newCategoryName)
        viewModel.categories.append(newCategory)
        newCategoryName = ""
    }

    func deleteCategory(_ category: Category) {
        viewModel.categories.removeAll { $0.id == category.id }
        viewModel.items.removeAll { $0.category.id == category.id }
        viewModel.cartItems.removeAll { $0.item.category.id == category.id }
    }
}
