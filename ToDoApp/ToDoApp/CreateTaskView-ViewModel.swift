//
//  CreateTaskView-ViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-01.
//

import Foundation

extension CreateTaskView{
    @MainActor class CreateTaskViewModel: ObservableObject{
        @Published var title: String = "Default Title"
        @Published var titleInput: String = ""
        @Published var dateInput: Date?
        @Published var selectedDates: Set<DateComponents> = []
        @Published var mydates: String = ""
    }
}
