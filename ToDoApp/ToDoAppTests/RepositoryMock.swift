//
//  RepositoryMock.swift
//  ToDoAppTests
//
//  Created by Trong Hieu Vuong on 2022-12-30.
//

import Foundation
class RepositoryMock: Repository {
    override func createOrUpdate<T>(_ value: T) async -> Result<T, RepositoryError> where T: Identifiable, T: Encodable, T.ID == UUID {
        guard let encodedValue = value.toDictionary else {
            return RepositoryError.createOrUpdateError
        }
        do {
            try await  self.child(UUID().uuidString).setValue(encodedValue)
        } catch {
            return .failure(RepositoryError.createOrUpdateError)
        }
        return .success(value)
    }
}
