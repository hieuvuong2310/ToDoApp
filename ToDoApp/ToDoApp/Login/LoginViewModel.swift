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
    var onSignUp: () -> Void = { fatalError("LoginViewModel.onSignUp was invoked before being initialized") }
    var onLogin: (String) -> Void = { _ in fatalError("LoginViewModel.onLogin was invoked before being initialized") }
    init(authenticateUser: AuthenticateUser, passwordValidate: PasswordValidator, onSignUp: (() -> Void)?, onLogin: ((String) -> Void)?) {
        self.authenticateUser = authenticateUser
        self.passwordValidate = passwordValidate
        if let onSignUp {
            self.onSignUp = onSignUp
        }
        if let onLogin {
            self.onLogin = onLogin
        }
    }
    convenience init(onSignUp: (() -> Void)? = nil, onLogin: ((String) -> Void)? = nil) {
        self.init(authenticateUser: Auth.auth(), passwordValidate: PasswordValidatorImpl(), onSignUp: onSignUp, onLogin: onLogin)
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
                navigateToListView(userId: user.id)
            case .failure(_):
                error = .authenticationError
            }
        }
    }
    func forgotPassword() {
        print("Forgot password")
    }
    func signUpButtonTapped() {
        onSignUp()
    }
    private func navigateToListView(userId: String) {
        onLogin(userId)
    }
    private func trimTextField() {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
