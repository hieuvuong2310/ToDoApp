//
//  LoginViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//
import Foundation
import FirebaseAuth
enum SignInError: Identifiable, Hashable {
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
    @Published var error: SignInError?
    @Published var email: String = ""
    @Published var password: String = ""
    private let authenticateUser: AuthenticateUser
    private let passwordValidate: PasswordValidator
    init(authenticateUser: AuthenticateUser, passwordValidate: PasswordValidator) {
        self.authenticateUser = authenticateUser
        self.passwordValidate = passwordValidate
    }
    convenience init() {
        self.init(authenticateUser: Auth.auth(), passwordValidate: PasswordValidatorImpl())
    }
    func signInButtonTapped() {
        trimTextField()
        if self.email == "" {
            error = .invalidEmail
            return
        }
        if !passwordValidate.validate(password: self.password) {
            error = .invalidPassword
            return
        }
        Task {
            let result = await authenticateUser.login(email: self.email, password: self.password)
            switch result {
            case .success(let user):
                print(user)
                navigateToListView()
            case .failure(_):
                error = .authenticationError
            }
        }
    }
    func forgotPassword() {
        print("Forgot password")
    }
    func signUpButtonTapped() {
        print("Sign up")
    }
    private func navigateToListView() {
        print("List View")
    }
    private func trimTextField() {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
