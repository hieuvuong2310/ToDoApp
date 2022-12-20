//
//  LoginViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import Foundation
@MainActor
class LoginViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: InputErrors?
    @Published var email: String = ""
    @Published var password: String = ""
}
