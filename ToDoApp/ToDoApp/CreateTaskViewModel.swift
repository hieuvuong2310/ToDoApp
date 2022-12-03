//
//  CreateTaskView+ModelView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation

extension CreateTaskView {
    @MainActor class CreateTaskViewModel: ObservableObject {
        @Published private(set) var titleInput: String = ""
        @Published private(set) var dateInput: Date?
        func onCancelButtonTapped() {
            print("Cancelled")
        }
        func onSaveButtonTapped(inputTitle: String, date: Date?) {
            print(inputTitle)
            print(date!)
        }
    }
}
