//
//  ToDoServiceImpl.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-23.
//

import Foundation
import FirebaseDatabase
struct TaskModel: Identifiable, Codable {
    let id: UUID
    var title: String
    var deadline: Date
    var status: Bool = false
}

struct ToDoTasks: Codable {
    var today: [TaskModel]
    var other: [TaskModel]
}
protocol DateChecker {
    func isDateInToday(_ date: Date) -> Bool
}
//  conform Calendar to this protocol
extension Calendar: DateChecker {}

protocol ToDoService {
    func createTask(title: String, deadline: Date) async -> Result<TaskModel, RepositoryError>
    func updateTask(todo: TaskModel) async -> Result<TaskModel, RepositoryError>
    func getTasks() async -> Result<ToDoTasks, RepositoryError>
}

final class ToDoServiceImpl: ToDoService {
    // MARK: - Dependencies
    private let dateChecker: DateChecker
    private let repo: Repository
    private let userId: String
    // MARK: - Init
    init(dateChecker: DateChecker, repo: Repository, userId: String) {
        self.dateChecker = dateChecker
        self.repo = repo
        self.userId = userId
        print(self.userId)
    }
    func createTask(title: String, deadline: Date) async -> Result<TaskModel, RepositoryError>{
        let oneTask = TaskModel(id: UUID(), title: title, deadline: deadline)
        return await updateTask(todo: oneTask)
    }
    func updateTask(todo: TaskModel) async -> Result<TaskModel, RepositoryError> {
        let error = await repo.createOrUpdate(todo, self.userId)
        if let error {
            return .failure(error)
        }
        return .success(todo)
    }
    func getTasks() async -> Result<ToDoTasks, RepositoryError> {
        let result: Result<[TaskModel], _> = await repo.read(self.userId)
        switch result {
        case .success(let tasks):
            var today: [TaskModel] = []
            var other: [TaskModel] = []
            for task in tasks.sorted(by: { $0.deadline < $1.deadline }) {
                if dateChecker.isDateInToday(task.deadline) {
                    today.append(task)
                } else {
                    other.append(task)
                }
            }
            return .success(ToDoTasks(today: today, other: other))
        case .failure(let error):
            return .failure(error)
        }
    }
}
