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
    init(authenticateUser: AuthenticateUser) {
        self.authenticateUser = authenticateUser
    }
    convenience init() {
        self.init(authenticateUser: Auth.auth())
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
        if !isPasswordValid(self.password) {
            error = .invalidPassword
            return
        }
        Task {
            let result = await authenticateUser.create(email: self.email, password: self.password)
            switch result {
            case .success(let user):
                print(user)
                navigateToListView()
            case .failure(_):
                error = .authenticationError
            }
        }
    }
    func signInButtonTapped() {
        print("Sign in")
    }
    func acceptTermsAndConditionsCheckBoxTapped() {
        isAcceptTermsAndConditionsChecked.toggle()
    }
    private func trimTextField() {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    private func navigateToListView() {
        print("List View")
    }
}
