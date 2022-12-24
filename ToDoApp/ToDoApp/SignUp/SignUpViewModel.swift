//
//  SignUpViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import Foundation
import FirebaseAuth
enum SignUpErrors: Identifiable, Hashable {
    var id: Int {
        hashValue
    }
    case invalidEmail
    case invalidPassword
    case invalidName
    case authenticationError
}
@MainActor
class SignUpViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: SignUpErrors?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var isCheckBoxTapped: Bool = false
    private let generateUser: GenerateUser = GenerateUser()
    private func trimTextField() {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func signUp() {
        trimTextField()
        if self.name == "" {
            error = .invalidPassword
            return
        }
        if self.email == "" {
            error = .invalidEmail
            return
        }
        if !isPasswordValid(self.password) {
            error = .invalidPassword
            return
        }
        Auth.auth().createUser(withEmail: self.email, password: self.password) {
            (result, error) in
            if error != nil {
                self.error = .authenticationError
                return
            } else {
                self.generateUser.createUser(id: result!.user.uid, email: self.email)
            }
        }
        navigateToListView()
    }
    private func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func navigateToSignIn() {
        print("Sign in")
    }
    func navigateToListView() {
        print(generateUser.getUserId())
    }
    func checkBoxTapped() {
        isCheckBoxTapped.toggle()
    }
}
