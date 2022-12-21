//
//  LoginViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import Foundation
@MainActor
enum SignInErrors: Identifiable, Hashable {
    var id: Int {
        hashValue
    }
    case invalidEmail
    case invalidPassword
}
class LoginViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: SignInErrors?
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() {
        if self.email == "" {
            error = .invalidEmail
        }
        if self.password == "" {
            error = .invalidPassword
        }
        print(email)
        print(password)
    }
    
    func forgotPassword() {
        print("Forgot password")
    }
    
    func navigateToSignUp() {
        print("Sign up")
    }
}
