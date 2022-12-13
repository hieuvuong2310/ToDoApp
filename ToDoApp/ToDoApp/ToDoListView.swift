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
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    let addButttonSize = Constants.addButtonSize
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .failed(let error):
                    Text(error.localizedDescription)
                case .loaded(let sections):
                    List {
                        ForEach(sections) { tasks in
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
                    .listStyle(.plain)
                    .padding(.bottom, addButttonSize)
                }
                Button( action: {
                    viewModel.addButtonTapped()
                }, label: {
                    Image(systemName: "plus")
                        .frame(minWidth: addButttonSize, minHeight: addButttonSize)
                        .foregroundColor(.white)
                        .background(Color(.primaryButton))
                        .clipShape(Circle())
                }
                )
                .sheet(item: $viewModel.destination, onDismiss: { viewModel.reload()
                    viewModel.onAppear()
                }) { destination in
                    switch destination {
                    case .addTask(let viewModel):
                        CreateTaskView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("To-Do List")
        }
        .onAppear {
            viewModel.onAppear()
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
        return deadline.formatted(date: .abbreviated, time: .shortened)
    }
}
private extension ToDoListView {
    enum Constants {
        static let addButtonSize: CGFloat = 57
    }
}
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
