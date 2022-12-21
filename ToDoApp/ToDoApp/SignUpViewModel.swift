//
//  SignUpViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import Foundation
enum SignUpErrors: Identifiable, Hashable {
    var id: Int {
        hashValue
    }
    case invalidEmail
    case invalidPassword
    case invalidName
}
@MainActor
class SignUpViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: SignUpErrors?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    func signUp() {
        if self.name == "" {
            error = .invalidPassword
        }
        if self.email == "" {
            error = .invalidEmail
        }
        if self.password == "" {
            error = .invalidPassword
        }
        print(email)
        print(password)
    }
    
    func navigateToSignIn() {
        print("Sign in")
    }
    
    func checkBoxTapped() {
        print("Checked")
    }
}
