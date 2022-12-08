//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-07.
//

import Foundation

class ToDoViewModel: ObservableObject {
    @Published var todo: TaskModel
    init(todo: TaskModel) {
        self.todo = todo
    }
    func getStatus() -> Bool {
        return todo.status
    }
    func updateStatus() {
        todo.status.toggle()
    }
}
