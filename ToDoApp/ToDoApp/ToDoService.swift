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

struct Task {
    let id: UUID = UUID()
    var title: String
    var note: String?
    var deadline: Date?
    var status: Bool = false
}

protocol DateChecker {
    func isDateInToday(_ date: Date) -> Bool
}
//  conform Calendar to this protocol
extension Calendar: DateChecker {}

protocol ToDoService {
    func createTask(title: String, note: String, deadline: Date?) async -> Result<Task, TaskError>
    func updateTask(todo: Task) async -> Result<Task, TaskError>
    func taskForToday() async -> Result<[Task], TaskError>
}

final class FeaturesToDo: ToDoService {
    // Private properties
    private var tasks: [Task] = []
    // MARK: - Dependencies
    private let dateChecker: DateChecker
    // MARK: - Init
    init(dateChecker: DateChecker) {
        self.dateChecker = dateChecker
    }
    convenience init() {
        self.init(dateChecker: Calendar.current)
    }
    // Create a task
    func createTask(title: String, note: String, deadline: Date?) async -> Result<Task, TaskError> {
        let oneTask = Task(title: title, note: note, deadline: deadline)
        tasks.append(oneTask)
        return Result.success(oneTask)
    }
    // Update the task
    func updateTask(todo: Task) async -> Result<Task, TaskError> {
        guard let index = tasks.firstIndex(where: {
            $0.id == todo.id
        })else {
            return Result.failure(TaskError.unavailableTask)
        }
        tasks[index] = todo
        return Result.success(todo)
    }
    // Get list of tasks for today
    func taskForToday() async -> Result<[Task], TaskError> {
        let todayTasks = tasks.filter {
            if let deadline = $0.deadline {
                return dateChecker.isDateInToday(deadline)
            }
            return false
        }
        return Result.success(todayTasks)
    }
}
