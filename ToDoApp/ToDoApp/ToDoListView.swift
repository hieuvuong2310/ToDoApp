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
    @State var showSheet: Bool = false
    static let items: [ToDoSection] = [
            .init(title: "Today’s To-Do List", toDoItems: [
                .init(title: "Cleaning", deadline: Date(), status: false),
                .init(title: "Cooking", deadline: Date(), status: true)
            ]),
            .init(title: "All To-Do List", toDoItems: [
                .init(title: "Laundry", deadline: Date(), status: false),
                .init(title: "Painting", deadline: Date(), status: true)
            ])
        ]
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(alignment: .leading) {
                Text("To-Do List")
                    .font(.system(size: 34))
                    .bold()
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
                    Divider()
                    ForEach(tasks.toDoItems) { todo in
                        CellTask(todo: todo)
                    }
                    
                }
            }
            Spacer()
            Button( action: {
                showSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .frame(minWidth: 57, minHeight: 57)
                        .foregroundColor(.white)
                        .background(Color(.primaryButton))
                        .clipShape(Circle())
                }
            )
            .sheet(isPresented: $showSheet) {
                CreateTaskView()
            }
        }
        .padding(16)
    }
}
struct CellTask: View {
    let todo: TaskModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button( action: {
                    ToDoViewModel(todo: todo).updateStatus()
                    }, label: {
                        Image(systemName: (ToDoViewModel(todo: todo).getStatus() ? "checkmark.circle" : "circle"))
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

                }
            }
            Divider()
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
