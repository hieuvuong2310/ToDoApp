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
    var id: UUID = UUID()
    var title: String = "New Task"
    var note: String = "New Note"
    var deadline: Date?
    var status: Bool = false
}

protocol ToDoService {
    func createTask(title: String, note: String, deadline: Date?) async -> Result<Task, TaskError>
    func updateTask(todo: Task) async -> Result<Task, TaskError>
    func taskForToday() -> [Task]
    func checkIsToday(date: Date?) -> Bool
}

final class FeaturesToDo: ToDoService {
    private var tasks: [Task] = []
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
    func taskForToday() -> [Task] {
        let date = Date.now
        let todayList = tasks.filter({checkIsToday(date: $0.deadline ?? nil)})
        return todayList
    }
    // Check whether the deadline is today
    func checkIsToday(date: Date?) -> Bool {
        var cal: Calendar = Calendar(identifier: .hebrew)
        if date == nil {
            return false
        }
        return cal.isDateInToday(date!)
    }
}
