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
            XCTFail("Fail to create task.")
            return
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
            XCTFail("Fail to create task.")
            return
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
        let todayId = UUID()
        let otherDayId = UUID()
        let today = Date()
        let tasks: [TaskModel] = [
                .init(id: todayId
                      , title: "Cleaning", deadline: today, status: false),
                .init(id: otherDayId, title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: true)
            ]
        
        let repositoryMock: RepositoryMock<TaskModel> = RepositoryMock(createOrUpdate: { value in
            // Mock repository behaviour returns nil error
            XCTFail("Fail to create task.")
            return
        }, read: {
            return .success(tasks)
        })
        let todoService = ToDoServiceImpl(dateChecker: Calendar.current, repo: repositoryMock)
        let result = await todoService.getTasks()
        guard case .success(let todoModel) = result else {
            XCTFail("Result expected to be success")
            return
        }
        XCTAssertEqual (todoModel, .init(today: [.init(id: todayId, title: "Cleaning", deadline: today, status: false)],
                other: [
                    .init(id: otherDayId, title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: true)
                ]))
    }
}
