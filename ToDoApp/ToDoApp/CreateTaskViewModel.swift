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
struct DefaultValue {
    var titleInput: String
    var date: Date
}
class CreateTaskViewModel: ObservableObject {
    @Published var error: InputErrors?
    private let taskService: ToDoService
    init(taskService: ToDoService) {
        self.taskService = taskService
    }
    convenience init() {
        self.init(taskService: FeaturesToDo())
    }
    // Handle when "Cancelled" button is tapped
    func onCancelButtonTapped() -> DefaultValue{
        return DefaultValue(titleInput: "", date: Date())
    }
    // Handle when "Save" button is tapped
    func onSaveButtonTapped(inputTitle: String, date: Date) {
        // Check whether the input is correct or not.
        if inputTitle == ""{
            error = .invalidTitle
        } else {
            Task {
                await taskService.createTask(title: inputTitle, deadline: date)
            }
        }
    }
}
