//
//  CreateTaskViewModel.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation

enum InputErrors: Error{
    case InvalidTitle
}

class CreateTaskViewModel: ObservableObject {
    
    @Published var loadedTask: Bool = true
    
    private let taskService: ToDoService
    
    init(taskService: ToDoService){
        self.taskService = taskService
    }
    convenience init(){
        self.init(taskService: FeaturesToDo())
    }
    
    func onCancelButtonTapped() {
        print("Cancelled")
    }
    func onSaveButtonTapped(inputTitle: String, date: Date) async -> Result<Bool, InputErrors>{
        //Check whether the input is correct or not.
        if inputTitle == ""{
            self.loadedTask = false;
            print("A")
            return .failure(InputErrors.InvalidTitle)
        }
        let result = await taskService.createTask(title: inputTitle, deadline: date)
        return .success(true)
    }
}
