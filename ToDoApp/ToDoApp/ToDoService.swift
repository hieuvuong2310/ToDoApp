//
//  ToDoDetail.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-11-29.
//

import Foundation

enum TaskError: Error {
    case unavailableTask
}

struct TaskModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var deadline: Date
    var status: Bool = false
}

struct ToDoTasks {
    var today: [TaskModel]
    var other: [TaskModel]
}
protocol DateChecker {
    func isDateInToday(_ date: Date) -> Bool
}
//  conform Calendar to this protocol
extension Calendar: DateChecker {}

protocol ToDoService {
    func createTask(title: String, deadline: Date) async -> Result<TaskModel, TaskError>
    func updateTask(todo: TaskModel) async -> Result<TaskModel, TaskError>
    func getTasks() async -> Result<ToDoTasks, TaskError>
    func updateTaskStatus(id: UUID) async -> Result<TaskModel, TaskError>
}

final class FeaturesToDo: ToDoService {
    // Private properties
    private var tasks: [TaskModel] = [
        .init(title: "Cleaning", deadline: Date(), status: false),
        .init(title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: true),
        .init(title: "Painting", deadline: Date(), status: true),
        .init(title: "Learning", deadline: Date(timeIntervalSince1970: 1636600477), status: true),
        .init(title: "Midterm", deadline: Date(), status: true),
        .init(title: "Laundry", deadline: Date(timeIntervalSince1970: 1702350877), status: false),
        .init(title: "Clean car", deadline: Date(), status: true),
        .init(title: "Workout", deadline: Date(), status: true),
        .init(title: "Cooking", deadline: Date(), status: false),
        .init(title: "Final for Introduction to Computer Theory and Processing, Algorithms", deadline: Date(timeIntervalSince1970: 1702350877), status: false),
        .init(title: "Clean car", deadline: Date(), status: true),
        .init(title: "Workout", deadline: Date(), status: true),
        .init(title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: false)
    ]
    // MARK: - Dependencies
    private let dateChecker: DateChecker
    // MARK: - Init
    init(dateChecker: DateChecker) {
        self.dateChecker = dateChecker
    }
    convenience init() {
        self.init(dateChecker: Calendar.current)
        print(tasks)
    }
    // Create a task
    func createTask(title: String, deadline: Date) async -> Result<TaskModel, TaskError> {
        let oneTask = TaskModel(title: title, deadline: deadline)
        tasks.append(oneTask)
        return .success(oneTask)
    }
    // Update the task
    func updateTask(todo: TaskModel) async -> Result<TaskModel, TaskError> {
        guard let index = tasks.firstIndex(where: {
            $0.id == todo.id
        })else {
            return .failure(TaskError.unavailableTask)
        }
        tasks[index] = todo
        return .success(todo)
    }
    // Get all the tasks in the storage and put them into correct buckets
    func getTasks() async -> Result<ToDoTasks, TaskError> {
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
    }
    // Update task status
    func updateTaskStatus(id: UUID) async -> Result<TaskModel, TaskError>{
        guard let index = tasks.firstIndex(where: {
            $0.id == id
        }) else {
            return .failure(TaskError.unavailableTask)
        }
        var todo = tasks[index]
        todo.status.toggle()
        tasks[index] = todo
        return .success(todo)
    }
}
