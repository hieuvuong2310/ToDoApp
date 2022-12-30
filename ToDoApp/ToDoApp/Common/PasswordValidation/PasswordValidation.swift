//
//  PasswordValidation.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-29.
//

import Foundation
protocol PasswordValidator {
    func validate(password: String) -> Bool
}

final class PasswordValidatorImpl: PasswordValidator {
    func validate(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
