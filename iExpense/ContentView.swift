//
//  ContentView.swift
//  iExpense
//
//  Created by Jason Cox on 11/3/24.
//


import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    var body: some View {
        Button("Dismiss"){
            dismiss()
        }
    }
}

struct ContentView: View {
@State private var showingSheet: Bool = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "@WinterEC")
            }

        }

    }
}

#Preview {
    ContentView()
}
