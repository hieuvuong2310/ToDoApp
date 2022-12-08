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
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: false),
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: true),
                .init(title: "Cooking", deadline: Date(), status: false)
                
            ]),
            .init(title: "All To-Do List", toDoItems: [
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: true),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: true),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Laundry", deadline: Date(), status: false),
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
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        Text("\(tasks.toDoItems.capacity) tasks left")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .fontWeight(.thin)
                    }
                    ForEach(tasks.toDoItems) { todo in
                        CellTask(todo: todo)
                    }
                }
                Spacer()
            }
            .navigationTitle("To-Do List")
        }
    }
}
struct CellTask: View {
    var todo: TaskModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button( action: {
                    print("Change status")
                }, label: {
                        Image(systemName: (todo.status ? "checkmark.circle" : "circle"))
                            .frame(minWidth: 22, minHeight: 22)
                            .clipShape(Circle())
                            .tint(.blue)
                    }
                )
                .padding(.trailing, 30.0)
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .bold()
                        .font(.system(size: 17))
                    Text(formatDate(deadline: todo.deadline))
                        .font(.system(size: 15))
                }
            }
        }
    }
    func formatDate(deadline: Date) -> String {
        return deadline.formatted(.iso8601.month().day().year().dateSeparator(.dash))
    }
}
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
