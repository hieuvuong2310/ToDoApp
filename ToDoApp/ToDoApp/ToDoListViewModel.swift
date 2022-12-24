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
        case loaded([ToDoSection])
        case failed(Error)
    }
    enum UpdateError: Identifiable, Hashable {
        case updateStatusFailed
        var id: Int {
            hashValue
        }
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
    @Published private(set) var loading: Bool = false
    @Published var error: UpdateError?
    private let taskService: ToDoService
    init(taskService: ToDoService) {
        self.taskService = taskService
    }
    convenience init() {
        self.init(taskService: ToDoServiceImpl())
    }
    func onAppear() {
        if case .loaded = state {
            return
        }
        fetchToDoTasks()
    }
    // Handle add button tapped
    func addButtonTapped() {
        addEditButtonTapped(mode: .createNewTask)
    }
    // Handle edit button tapped
    func editButtonTapped(todo: TaskModel) {
        addEditButtonTapped(mode: .editExistingTask(todo))
    }
    // Handle eddting or creating task when edit or add button is tapped
    private func addEditButtonTapped(mode: CreateTaskViewMode) {
        let createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel(taskService: taskService, mode: mode) { [weak self] in
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
        if loading {
            return
        }
        loading = true
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
            loading = false
        }
    }
    // Update the status of the task
    func updateStatus(todo: TaskModel) {
        Task {
            var task = todo
            task.status.toggle()
            let result = await taskService.createOrUpdateTask(todo: task)
            switch result {
            case .success(_):
                self.fetchToDoTasks()
            case .failure(_):
                error = .updateStatusFailed
            }
        }
    }
    // Handle when retry button is tapped
    func retryButtonTapped() {
        self.fetchToDoTasks()
    }
}
