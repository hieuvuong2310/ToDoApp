//
//  Encodable+Convenience.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-22.
//

import Foundation
extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
