//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-09.
//

import Foundation

final class ToDoListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([ToDoSection])
        case failed(Error)
    }
    enum Destination: Identifiable {
        var id: String {
            return "id"
        }
        case addTask(CreateTaskViewModel)
    }
    @Published var destination: Destination?
    @Published var state: State = .idle
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
    // Tap add button
    func addButtonTapped() {
        let createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
        destination = .addTask(createTaskViewModel)
    }
    // Reload the state when navigate to ToDoListView
    func reload() {
        state = .idle
    }
}
