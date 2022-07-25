//
//  ContentView.swift
//  ExTextField
//
//  Created by Jake.K on 2022/07/25.
//

import SwiftUI

struct ContentView: View {
  enum Field {
    case username
    case email
  }
  
  @State private var username = ""
  @State private var email = ""
  @FocusState private var focusField: Field?
  
  var body: some View {
    VStack {
      TextField(
        "User name",
        text: $username
      )
      .keyboardType(.numberPad)
      .onSubmit {
        print("user did tap return , \(username)")
      }
      .textInputAutocapitalization(.never)
      .disableAutocorrection(true)
      .textFieldStyle(.roundedBorder)
      .focused($focusField, equals: .username)
      
      TextField(
        "Email",
        text: $email
      )
      .focused($focusField, equals: .email)
      
      Button("Sign in") {
        if username.isEmpty {
          focusField = .username
        } else if email.isEmpty {
          focusField = .email
        } else {
          hideKeyboard()
          print("Complete Input and sign in...")
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // <-
    .onTapGesture { // <-
      hideKeyboard()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
