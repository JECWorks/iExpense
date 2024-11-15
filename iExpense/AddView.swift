//
//  AddView.swift
//  iExpense
//
//  Created by Jason Cox on 11/14/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var amount = 0.0
    @State private var type = "Personal"
    
    var expenses: Expenses
    
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
            }
            .navigationTitle("Add new expense")
        }
    }
}


#Preview {
    AddView(expenses: Expenses())
}
