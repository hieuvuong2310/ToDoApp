////
////  ToDoDetail.swift
////  ToDoApp
////
////  Created by Trong Hieu Vuong on 2022-11-29.
////
//
//import Foundation
//
//enum TaskError: Error {
//    case unavailableTask
//}
//
//struct TaskModel: Identifiable, Codable {
//    let id: UUID
//    var title: String
//    var deadline: Date
//    var status: Bool = false
//}
//
//struct ToDoTasks {
//    var today: [TaskModel]
//    var other: [TaskModel]
//}
//protocol DateChecker {
//    func isDateInToday(_ date: Date) -> Bool
//}
////  conform Calendar to this protocol
//extension Calendar: DateChecker {}
//
//protocol ToDoService {
//    func createTask(title: String, deadline: Date) async -> Result<TaskModel, TaskError>
//    func updateTask(todo: TaskModel) async -> Result<TaskModel, TaskError>
//    func getTasks() async -> Result<ToDoTasks, TaskError>
//}
//
//final class FeaturesToDo: ToDoService {
//    // Private properties
//    private var tasks: [TaskModel] = [
//        .init(id: UUID()
//              , title: "Cleaning", deadline: Date(), status: false),
//        .init(id: UUID(), title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: true),
//        .init(id: UUID(), title: "Painting", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Learning", deadline: Date(timeIntervalSince1970: 1636600477), status: true),
//        .init(id: UUID(), title: "Midterm", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Laundry", deadline: Date(timeIntervalSince1970: 1702350877), status: false),
//        .init(id: UUID(), title: "Clean car", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Workout", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Cooking", deadline: Date(), status: false),
//        .init(id: UUID(), title: "Final for Introduction to Computer Theory and Processing, Algorithms",
//              deadline: Date(timeIntervalSince1970: 1702350877), status: false),
//        .init(id: UUID(), title: "Clean car", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Workout", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Cooking", deadline: Date(timeIntervalSince1970: 1670128119), status: false),
//        .init(id: UUID(), title: "Study", deadline: Date(), status: false),
//        .init(id: UUID(), title: "Project", deadline: Date(timeIntervalSince1970: 1670128119), status: true),
//        .init(id: UUID(), title: "Iron clothes", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Shopping", deadline: Date(timeIntervalSince1970: 1636600477), status: true),
//        .init(id: UUID(), title: "Final", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Clean dishes", deadline: Date(timeIntervalSince1970: 1702350877), status: false),
//        .init(id: UUID(), title: "Clean house", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Gym", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Swimming", deadline: Date(), status: false),
//        .init(id: UUID(), title: "Biking",
//              deadline: Date(timeIntervalSince1970: 1702350877), status: false),
//        .init(id: UUID(), title: "Clean kitchen", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Hiking", deadline: Date(), status: true),
//        .init(id: UUID(), title: "Skating", deadline: Date(timeIntervalSince1970: 1670128119), status: false)
//    ]
//    // MARK: - Dependencies
//    private let dateChecker: DateChecker
//    // MARK: - Init
//    init(dateChecker: DateChecker) {
//        self.dateChecker = dateChecker
//    }
//    convenience init() {
//        self.init(dateChecker: Calendar.current)
//    }
//    // Create a task
//    func createTask(title: String, deadline: Date) async -> Result<TaskModel, TaskError> {
//        let oneTask = TaskModel(id: UUID(), title: title, deadline: deadline)
//        tasks.append(oneTask)
//        return .success(oneTask)
//    }
//    // Update the task
//    func updateTask(todo: TaskModel) async -> Result<TaskModel, TaskError> {
//        guard let index = tasks.firstIndex(where: {
//            $0.id == todo.id
//        })else {
//            return .failure(TaskError.unavailableTask)
//        }
//        tasks[index] = todo
//        return .success(todo)
//    }
//    // Get all the tasks in the storage and put them into correct buckets
//    func getTasks() async -> Result<ToDoTasks, TaskError> {
//        var today: [TaskModel] = []
//        var other: [TaskModel] = []
//        for task in tasks.sorted(by: { $0.deadline < $1.deadline }) {
//            if dateChecker.isDateInToday(task.deadline) {
//                today.append(task)
//            } else {
//                other.append(task)
//            }
//        }
//        return .success(ToDoTasks(today: today, other: other))
//    }
//}
