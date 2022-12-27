//
//  LoginViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//
import Foundation
import FirebaseAuth
enum SignInErrors: Identifiable, Hashable {
    var id: Int {
        hashValue
    }
    case invalidEmail
    case invalidPassword
    case authenticationError
}
@MainActor
class LoginViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: SignInErrors?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userId: String = ""
    private func trimTextField() {
            self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    func signIn() {
        trimTextField()
        if self.email == "" {
            error = .invalidEmail
            return
        }
        if !isPasswordValid(self.password) {
            error = .invalidPassword
            return
        }
        Auth.auth().signIn(withEmail: self.email, password: self.password) {
                    (result, error) in
                    if error != nil {
                        self.error = .authenticationError
                        return
                    } else {
                        self.userId = result!.user.uid
                    }
                }
        print(self.userId)
    }
    private func isPasswordValid(_ password : String) -> Bool {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    func forgotPassword() {
        print("Forgot password")
    }

    func navigateToSignUp() {
        print("Sign up")
    }
}
