//
//  ToDoServiceTests.swift
//  ToDoAppTests
//
//  Created by Trong Hieu Vuong on 2022-12-30.
//
import XCTest
@testable import ToDoApp

final class RepositoryMock<Value>: Repository where Value: Identifiable, Value: Encodable, Value.ID == UUID {
    private let _createOrUpdate: (Value) -> RepositoryError?
    private let _read: () -> Result<[Value], RepositoryError>
    init(createOrUpdate: @escaping (Value) -> RepositoryError?, read: @escaping () -> Result<[Value], RepositoryError>) {
        self._createOrUpdate = createOrUpdate
        self._read = read
    }
    
    func createOrUpdate<T>(_ value: T) async -> RepositoryError? where T: Identifiable, T: Encodable, T.ID == UUID {
        _createOrUpdate(value as! Value)
    }
    func read<T>() async ->Result<[T], RepositoryError> where T: Decodable {
        _read() as! Result<[T], RepositoryError>
    }
}
final class ToDoServiceTests: XCTestCase {

    func testCreateTask_Success() async {
        var capturedValue: TaskModel?
        let repositoryMock: RepositoryMock<TaskModel> = RepositoryMock(createOrUpdate: { value in
            capturedValue = value
            // Mock repository behaviour returns nil error
            return nil
        }, read: {
            return .failure(RepositoryError.createOrUpdateError)
        })
        let todoService = ToDoServiceImpl(dateChecker: Calendar.current, repo: repositoryMock)
        
        let result = await todoService.createTask(title: "Cooking", deadline: Date(timeIntervalSince1970: 1672558922))
        guard case .success(let todoModel) = result else {
            XCTFail("Result expected to be success")
            return
        }
        XCTAssertEqual(todoModel.title, "Cooking")
        XCTAssertEqual(todoModel.deadline, Date(timeIntervalSince1970: 1672558922))
        XCTAssertFalse(todoModel.status)
        XCTAssertEqual(capturedValue, todoModel)
    }
    
    func testCreateTask_Fail() async {
        let repositoryMock: RepositoryMock<TaskModel> = RepositoryMock(createOrUpdate: { value in
            // Mock repository behaviour returns nil error
            return RepositoryError.createOrUpdateError
        }, read: {
            return .failure(RepositoryError.createOrUpdateError)
        })
        let todoService = ToDoServiceImpl(dateChecker: Calendar.current, repo: repositoryMock)
        let result = await todoService.createTask(title: "Cooking", deadline: Date(timeIntervalSince1970: 1672558922))
        guard case .failure(let failure) = result else {
            XCTFail("Result expected to fail")
            return
        }
        XCTAssertEqual(failure, RepositoryError.createOrUpdateError)
    }
    
    func testGetTask_Success() async {
        let repositoryMock: RepositoryMock<TaskModel> = RepositoryMock(createOrUpdate: { value in
            // Mock repository behaviour returns nil error
            return RepositoryError.createOrUpdateError
        }, read: {
            return .success([TaskModel(id: UUID(), title: "Hi", deadline: Date(timeIntervalSince1970: 1672558922))])
        })
        let todoService = ToDoServiceImpl(dateChecker: Calendar.current, repo: repositoryMock)
        let result = await todoService.getTasks()
        guard case .success(let todoModel) = result else {
            XCTFail("Result expected to be success")
            return
        }
        XCTAssertEqual(todoModel.other[0].title, "Hi")
        XCTAssertEqual(todoModel.other[0].deadline, Date(timeIntervalSince1970: 1672558922))
    }
}
