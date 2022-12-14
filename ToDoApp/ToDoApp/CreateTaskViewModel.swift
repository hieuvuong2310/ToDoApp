//
//  CreateTaskViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation

enum InputErrors: Identifiable, Hashable {
    case invalidTitle
    case createTaskError
    case updateTaskError
    var id: Int {
        hashValue
    }
}
enum CreateTaskViewMode {
    case createNewTask
    case editExistingTask(TaskModel)
}
@MainActor
class CreateTaskViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: InputErrors?
    @Published var title: String
    @Published var deadline: Date
    let mode: CreateTaskViewMode
    // MARK: Dependencies
    private let taskService: ToDoService
    private let onSaved: () -> Void
    private let onCancelled: () -> Void
    init(taskService: ToDoService,
         mode: CreateTaskViewMode,
         onCancelled: @escaping () -> Void,
         onSaved: @escaping () -> Void
    ) {
        self.taskService = taskService
        self.onCancelled = onCancelled
        self.onSaved = onSaved
        self.mode = mode
        switch mode {
        case .createNewTask:
            self.title = ""
            self.deadline = Date()
        case .editExistingTask(let todo):
            self.title = todo.title
            self.deadline = todo.deadline
        }
    }
    // Handle when "Cancel" button is tapped
    func onCancelButtonTapped() {
        onCancelled()
    }
    // Handle when "Save" button is tapped
    func onSaveButtonTapped() {
        if title == "" {
            error = .invalidTitle
        } else {
            switch mode {
            case .createNewTask:
                Task {
                    let result = await taskService.createTask(title: title, deadline: deadline)
                    switch result {
                    case .success(_):
                        onSaved()
                    case .failure(_):
                        error = .createTaskError
                    }
                }
            case .editExistingTask(var todo):
                Task {
                    todo.title = title
                    todo.deadline = deadline
                    let result = await taskService.updateTask(todo: todo)
                    switch result {
                    case .success(_):
                        onSaved()
                    case .failure(_):
                        error = .updateTaskError
                    }
                }
            }
        }
    }
}
