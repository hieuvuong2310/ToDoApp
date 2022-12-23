//
//  Respository.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-22.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
protocol Repository {
    func updateAndCreate<T>(_ value: T) async -> Error? where T: Identifiable, T: Encodable, T.ID == UUID
    func read<T>() async -> Result<[T], Error> where T: Decodable
}
extension DatabaseReference: Repository {
  // MARK: create a task
    func updateAndCreate<T>(_ value: T) async -> Error? where T: Identifiable, T: Encodable, T.ID == UUID {
        do {
           try await self.child(value.id.uuidString).setValue(value.toDictionary)
        } catch {
            return TError.unsavedT
        }
        return nil
    }
    func read<T>() async -> Result<[T], Error> where T : Decodable {
        var task: [T] = [T]()
        self.observe(.value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            task = children.compactMap({ snapshot in
                return try? snapshot.data(as: T.self)
            })
        }
        return .success(task)
    }
}
extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
enum TError: Error {
    case unsavedT
    case unavailableT
}
