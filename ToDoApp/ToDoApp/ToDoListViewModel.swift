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
    @Published var state: State = .idle
    private let taskService: ToDoService = FeaturesToDo()
    func onAppear() {
        if case .loaded = state {
            return
        }
        state = .loading
        Task {
            let result = await taskService.getTasks()
            switch result {
            case .success(let todos):
                var todoSections: [ToDoSection] = []
                if !todos.today.isEmpty {
                    todoSections.append(ToDoSection(title: "Today’s To-Do List", toDoItems: todos.today))
                }
                if !todos.other.isEmpty {
                    todoSections.append(ToDoSection(title: "All To-Do List", toDoItems: todos.other))
                }
                state = .loaded(todoSections)
            case .failure(let error):
                state = .failed(error)
            }
        }
    }
}
