//
//  ToDoDetail.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-11-29.
//

import Foundation

enum TaskError: Error {
    case unavailableTask
}

struct Task{
    var id: String = ""
    var name: String = ""
    var deadline: Date = Date.now
    var status: Bool = false
    
    init(name: String, deadline: Date?){
        self.name = name
        self.deadline = deadline!
    }
}

protocol ToDoService{
    func createTask(name: String, deadline: Date?) -> Task
    func updateTask(todo: Task) throws
    func taskForToday() -> [Task]
}

final class FeaturesToDo: ToDoService{
    private var tasks: [Task] = []
    
    //Create a task
    func createTask(name: String, deadline: Date?) -> Task{
        let oneTask = Task(name: name, deadline: deadline)
        tasks.append(oneTask)
        return oneTask
    }
    
    //Update the task
    func updateTask(todo: Task) throws {
        guard let index = tasks.firstIndex(where: {
            $0.id == todo.id
        })else{
            throw TaskError.unavailableTask
        }
        tasks.insert(todo, at: index)
    }
    
    //Get list of tasks for today
    func taskForToday() -> [Task] {
        let date = Date.now
        let todayList = tasks.filter({$0.deadline == date})
        return todayList
    }
}

