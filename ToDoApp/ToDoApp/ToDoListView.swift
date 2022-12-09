//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-07.
//

import SwiftUI

struct ToDoSection: Identifiable {
    var id: UUID = UUID()
    let title: String
    let toDoItems: [TaskModel]
}
struct ToDoListView: View {
    static let items: [ToDoSection] = [
            .init(title: "Today’s To-Do List", toDoItems: [
                .init(title: "Cleaning", deadline: Date(), status: false),
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Painting", deadline: Date(), status: true),
                .init(title: "Learning", deadline: Date(), status: true),
                .init(title: "Midterm", deadline: Date(), status: true),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Clean car", deadline: Date(), status: true),
                .init(title: "Workout", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: false)
                
            ]),
            .init(title: "All To-Do List", toDoItems: [
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Cleaning", deadline: Date(), status: true),
                .init(title: "Final", deadline: Date(), status: false),
                .init(title: "Grocery", deadline: Date(), status: true),
                .init(title: "Dancing", deadline: Date(), status: false),
                .init(title: "Workout", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Drawing", deadline: Date(), status: false),
                .init(title: "Painting", deadline: Date(), status: true)
            ])
        ]
    var body: some View {
        NavigationStack{
            List {
                ForEach(ToDoListView.items) { tasks in
                    HStack(spacing: 6) {
                        Text(tasks.title)
                            .foregroundColor(Color(.caption))
                            .fontWeight(.medium)
                        Text("\(tasks.toDoItems.count) tasks left")
                            .foregroundColor(Color(.secondaryText))
                            
                    }
                    .font(.caption)
                    ForEach(tasks.toDoItems) { todo in
                        TaskCell(todo: todo)
                    }
                }
            }
            .navigationTitle("To-Do List")
            .listStyle(.plain)
        }
    }
}
struct TaskCell: View {
    var todo: TaskModel
    var body: some View {
        HStack(spacing: 30) {
            Button( action: {
                print("Change status")
            }, label: {
                    Image(systemName: (todo.status ? "checkmark.circle.fill" : "circle"))
                    .foregroundColor(Color(.checkmarkButton))
                }
            )
            VStack(alignment: .leading) {
                Text(todo.title)
                    .bold()
                    .font(.body)
                Text(formatDate(deadline: todo.deadline))
                    .font(.subheadline)
            }
        }
    }
    func formatDate(deadline: Date) -> String {
        return deadline.formatted()
    }
}
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
