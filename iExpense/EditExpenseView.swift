//
//  EditExpenseView.swift
//  iExpense
//
//  Created by Jason Cox on 11/19/24.
//
import SwiftUI

struct EditExpenseView: View {
    @Environment(\.dismiss) var dismiss

//    @Binding var expense: ExpenseItem
    var expense: ExpenseItem
    var expenses: Expenses

    @State private var name = ""
    @State private var amount = 0.0
    @State private var type = "Personal"
    @State private var date = Date()

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Edit Expense")
            .toolbar {
                Button("Save") {
                    saveChanges()
                    dismiss()
                }
            }
            .onAppear {
                loadExpenseDetails()
            }
        }
    }

    func loadExpenseDetails() {
        name = expense.name
        amount = expense.amount
        type = expense.type
        date = expense.date
    }
    
    func saveChanges() {
        if let index = expenses.items.firstIndex(where: { $0.id == expense.id }) {
            expenses.items[index] = ExpenseItem(
                id: expense.id,
                name: name,
                type: type,
                amount: amount,
                date: date
            )
        }
    }
}

//#Preview {
//    EditExpenseView(expense: .constant(nil), expenses: Expenses())
//}

