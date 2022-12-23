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
    func createOrUpdate<T>(_ value: T) async -> Error? where T: Identifiable, T: Encodable, T.ID == UUID
    func read<T>() async -> Result<[T], Error> where T: Decodable
}
extension DatabaseReference: Repository {
  // MARK: create a task
    func createOrUpdate<T>(_ value: T) async -> Error? where T: Identifiable, T: Encodable, T.ID == UUID {
        guard let encodedValue = value.toDictionary else {
            return .some("Error encoding value" as! Error)
        }
        do {
           try await  self.child(value.id.uuidString).setValue(encodedValue)
        } catch (let error) {
            return error
        }
        return nil
    }
    func read<T>() async -> Result<[T], Error> where T : Decodable {
        var task: [T] = []
        var taskError: Error?
        self.observe(.value) { parentSnapshot, error in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                taskError = .some("not available task" as! Error)
                return
            }
            task = children.compactMap({ snapshot in
                return try? snapshot.data(as: T.self)
            })
        }
        if taskError != nil {
            return .failure(taskError!)
        }
        return .success(task)
    }
}
