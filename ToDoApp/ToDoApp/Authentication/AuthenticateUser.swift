//
//  AuthenticateUser.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-28.
//

import Foundation
import FirebaseAuth
protocol AuthenticateUser {
    func create(email: String, password: String) async -> Result<UserData, AuthenticationError>
    func login(email: String, password: String) async -> Result<UserData, AuthenticationError>
}
enum AuthenticationError: Error {
    case createUserError
    case loginError
}
extension Auth: AuthenticateUser {
    func create(email: String, password: String) async -> Result<UserData, AuthenticationError> {
        do {
            let result = try await self.createUser(withEmail: email, password: password)
            return .success(UserData(id: result.user.uid, email: email))
        } catch {
            return .failure(.createUserError)
        }
    }
    func login(email: String, password: String) async -> Result<UserData, AuthenticationError> {
        do {
            let result = try await self.signIn(withEmail: email, password: password)
            return .success(UserData(id: result.user.uid, email: email))
        } catch {
            return .failure(.createUserError)
        }
    }
}
