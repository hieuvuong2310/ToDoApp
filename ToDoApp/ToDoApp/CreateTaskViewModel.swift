//
//  CreateTaskViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation

enum InputErrors: Identifiable, Hashable {
    case invalidTitle
    var id: Int {
        hashValue
    }
}
@MainActor
class CreateTaskViewModel: ObservableObject {
    // MARK: Internal Properties
    @Published var error: InputErrors?
    // MARK: Dependencies
    private let taskService: ToDoService
    private let onSaved: () -> Void
    private let onCancelled: () -> Void
    
    init(taskService: ToDoService,
         onCancelled: @escaping () -> Void,
         onSaved: @escaping () -> Void
    ) {
        self.taskService = taskService
        self.onCancelled = onCancelled
        self.onSaved = onSaved
    }
    // Handle when "Cancel" button is tapped
    func onCancelButtonTapped() {
        onCancelled()
    }
    // Handle when "Save" button is tapped
    func onSaveButtonTapped(inputTitle: String, date: Date) {
        // Check whether the input is correct or not.
        if inputTitle == ""{
            error = .invalidTitle
        } else {
            Task {
                _ = await taskService.createTask(title: inputTitle, deadline: date)
                onSaved()
            }
        }
    }
}
