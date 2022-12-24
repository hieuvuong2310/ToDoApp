//
//  UserData.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-23.
//

import Foundation
struct UserData: Codable {
    let id: String
    var email: String
}
class GenerateUser {
    private var user: UserData = UserData(id: "", email: "")
    func createUser(id: String, email: String) {
        self.user = UserData(id: id, email: email)
    }
    func getUserId() -> String{
        self.user.id
    }
}
