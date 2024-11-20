//
//  ContentView.swift
//  iExpense
//
//  Created by Jason Cox on 11/3/24.
//


import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let date: Date
}

//@Observable
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showingEditExpense = false
    @State private var expenseToEdit: ExpenseItem?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                        Text(item.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        Button("Edit") {
                            expenseToEdit = item
                            showingEditExpense = true
                        }
                        .tint(.blue)
                        
                        Button("Delete", role: .destructive) {
                            deleteItem(item)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .sheet(isPresented: $showingEditExpense) {
                if let expenseToEdit = expenseToEdit {
                    EditExpenseView(expense: expenseToEdit, expenses: expenses)
                }
            }
        }
    }
    
//    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
    func deleteItem(_ item: ExpenseItem) {
        if let index = expenses.items.firstIndex(where: { $0.id == item.id}) {
            expenses.items.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
