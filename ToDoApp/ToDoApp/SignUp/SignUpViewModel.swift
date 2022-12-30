//
//  SignUpViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import Foundation
import FirebaseAuth
enum SignUpError: Identifiable, Hashable {
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
    @Published var error: SignUpError?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published private(set) var isAcceptTermsAndConditionsChecked: Bool = false
    private let authenticateUser: AuthenticateUser
    private let passwordValidate: PasswordValidator
    private let onLogin: () -> Void
    private let onSignUp: (String) -> Void
    init(authenticateUser: AuthenticateUser, passwordValidate: PasswordValidator, onSignUp: @escaping (String) -> Void, onLogin: @escaping () -> Void) {
        self.authenticateUser = authenticateUser
        self.passwordValidate = passwordValidate
        self.onLogin = onLogin
        self.onSignUp = onSignUp
    }
    convenience init(onSignUp: @escaping (String) -> Void, onLogin: @escaping () -> Void) {
        self.init(authenticateUser: Auth.auth(), passwordValidate: PasswordValidatorImpl(), onSignUp: onSignUp, onLogin: onLogin)
    }
    func signUpButtonTapped() {
        trimTextField()
        if self.name == "" {
            error = .invalidPassword
            return
        }
        if self.email == "" {
            error = .invalidEmail
            return
        }
        if !passwordValidate.validate(password: self.password) {
            error = .invalidPassword
            return
        }
        Task {
            let result = await authenticateUser.create(email: self.email, password: self.password)
            switch result {
            case .success(let user):
                navigateToListView(userId: user.id)
            case .failure(_):
                error = .authenticationError
            }
        }
    }
    func signInButtonTapped() {
        onLogin()
    }
    func acceptTermsAndConditionsCheckBoxTapped() {
        isAcceptTermsAndConditionsChecked.toggle()
    }
    private func trimTextField() {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private func navigateToListView(userId: String) {
        onSignUp(userId)
    }
}
