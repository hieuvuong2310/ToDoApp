//
//  RootViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-29.
//

import Foundation
enum Destination: Identifiable {
    var id: ObjectIdentifier {
        switch self {
        case .login(let viewModel):
            return ObjectIdentifier(viewModel)
        case .signup(let viewModel):
            return ObjectIdentifier(viewModel)
        case .list(let viewModel):
            return ObjectIdentifier(viewModel)
        }
    }
    case login(LoginViewModel)
    case signup(SignUpViewModel)
    case list(ToDoListViewModel)
}
@MainActor
class RootViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var destination: Destination?
    init() {
        self.presentLoginFlow()
    }
}
extension RootViewModel {
    private func presentLoginFlow() {
        destination = .login(LoginViewModel(onSignUp: { [weak self] in
            self?.presentSignUpFlow()
        }, onLogin: { [weak self] userId in
            self?.presentListFlow(userId: userId)
        }))
    }
    private func presentSignUpFlow() {
        destination = .signup(SignUpViewModel( onSignUp: { [weak self] userId in
            self?.presentListFlow(userId: userId)
        }, onLogin: { [weak self] in
            self?.presentLoginFlow()
        }))
    }
    private func presentListFlow(userId: String) {
        destination = .list(ToDoListViewModel(userId: userId))
    }
}
