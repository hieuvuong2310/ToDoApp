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
    func createOrUpdate<T>(_ value: T) async -> RepositoryError? where T: Identifiable, T: Encodable, T.ID == UUID
    func read<T>() async -> Result<[T], RepositoryError> where T: Decodable
}
enum RepositoryError: Error {
    case createOrUpdateError
    case failedToFetchData
}
extension DatabaseReference: Repository {
    // MARK: create a task
    func createOrUpdate<T>(_ value: T) async -> RepositoryError? where T: Identifiable, T: Encodable, T.ID == UUID {
        guard let encodedValue = value.toDictionary else {
            return RepositoryError.createOrUpdateError
        }
        do {
            try await  self.child(value.id.uuidString).setValue(encodedValue)
        } catch {
            return RepositoryError.createOrUpdateError
        }
        return nil
    }
    func read<T>() async -> Result<[T], RepositoryError> where T : Decodable {
        do {
            let children = try await self.getData().children
            guard let allObjects = children.allObjects as? [DataSnapshot] else { return .failure(RepositoryError.failedToFetchData) }
            return .success(try allObjects.map{try $0.data(as: T.self)})
        } catch {
            return .failure(RepositoryError.failedToFetchData)
        }
    }
}
