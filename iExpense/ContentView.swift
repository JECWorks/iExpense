//
//  ContentView.swift
//  iExpense
//
//  Created by Jason Cox on 11/3/24.
//

import Observation
import SwiftUI

// if you use @State with a struct, it will update the whole view whenever it changes
// however, if you use @State with a class
// you mucst mark it as @Observable for it to behave that way
@Observable
// this tells SwiftUI to watch each individual property inside
// the class for changes and reloads any view that relies on
// a property when it changes
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
