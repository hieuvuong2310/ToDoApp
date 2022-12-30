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
    @Published private(set) var destination: Destination {
        didSet {
            bind()
        }
    }
    
    init() {
        destination = Self.makeLoginDestination()
        bind()
    }
}
extension RootViewModel {
    private static func makeLoginDestination() -> Destination {
        .login(LoginViewModel())
    }
    private static func makeSignUpDestination() -> Destination {
        .signup(SignUpViewModel())
    }
    private static func makeListDestination(userId: String) -> Destination {
        .list(ToDoListViewModel(userId: userId))
    }
    
    private func bind() {
        switch destination {
        case .login(let viewModel):
            viewModel.onSignUp = { [weak self] in
                guard let self else { return }
                self.destination = Self.makeSignUpDestination()
            }
            viewModel.onLogin = { [weak self] userId in
                guard let self else { return }
                self.destination = Self.makeListDestination(userId: userId)
            }
        case .signup(let viewModel):
            viewModel.onSignUp = { [weak self] userId in
                guard let self else { return }
                self.destination = Self.makeListDestination(userId: userId)
            }
            viewModel.onLogin = { [weak self] in
                guard let self else { return }
                self.destination = Self.makeLoginDestination()
            }
        case .list:
            break
        }
    }
}
