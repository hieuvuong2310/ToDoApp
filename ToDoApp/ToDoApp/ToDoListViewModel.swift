//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-09.
//

import Foundation

@MainActor
final class ToDoListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([ToDoSection])
        case failed(Error)
    }
    enum Destination: Identifiable {
        var id: ObjectIdentifier {
            switch self {
            case .addTask(let viewModel):
                return ObjectIdentifier(viewModel)
            }
        }
        case addTask(CreateTaskViewModel)
    }
    @Published private(set) var destination: Destination?
    @Published private(set) var state: State = .idle
    private let taskService: ToDoService
    init(taskService: ToDoService) {
        self.taskService = taskService
    }
    convenience init() {
        self.init(taskService: FeaturesToDo())
    }
    func onAppear() {
        if case .loaded = state {
            return
        }
        fetchToDoTasks()
    }
    // Tap add button
    func addButtonTapped() {
        let createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel(taskService: taskService) { [weak self] in
            self?.resetDestination()
        } onSaved: { [weak self] in
            self?.resetDestination()
            self?.fetchToDoTasks()
        }
        destination = .addTask(createTaskViewModel)
    }
    // Reset destination
    func resetDestination() {
        destination = nil
    }
    // Reload the state when navigate to ToDoListView
    private func fetchToDoTasks() {
        if case .loading = state {
            return
        }
        state = .loading
        Task {
            let result = await taskService.getTasks()
            switch result {
            case .success(let todos):
                var todoSections: [ToDoSection] = []
                if !todos.today.isEmpty {
                    todoSections.append(
                        ToDoSection(title: NSLocalizedString("Today’s To-Do List",
                                                             comment: "today tasks section title"),
                                    toDoItems: todos.today))
                }
                if !todos.other.isEmpty {
                    todoSections.append(
                        ToDoSection(title: NSLocalizedString("All To-Do List", comment: "other tasks section title"),
                                    toDoItems: todos.other))
                }
                state = .loaded(todoSections)
            case .failure(let error):
                state = .failed(error)
            }
        }
    }
    // Update the status of the task
    func updateStatus(id: UUID) {
        Task {
            _ = await taskService.updateTaskStatus(id: id)
            self.fetchToDoTasks()
        }
    }
}
