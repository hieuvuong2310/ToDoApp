//
//  CreateTaskView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation
import SwiftUI
import Introspect

struct CreateTaskView: View {
    @ObservedObject private var viewModel: CreateTaskViewModel
    init(viewModel: CreateTaskViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 21) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Task Name")
                        .foregroundColor(Color(.primaryText))
                    TextField("Insert Title", text: $viewModel.title)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.words)
                        .frame(minHeight: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.secondaryAccent), lineWidth: 1)
                        )
                        .introspectTextField(customize: {
                                $0.clearButtonMode = .whileEditing
                        })
                    }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of Completion")
                        .foregroundColor(Color(.primaryText))
                    DatePicker(selection: $viewModel.deadline) {
                        Text("Select date")
                            .foregroundColor(Color(.primaryText))
                    }
                    .padding(.horizontal, 16.0)
                    .frame(minHeight: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.secondaryAccent), lineWidth: 1)
                    )
                    .tint(Color(.secondaryAccent))
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.onCancelButtonTapped()
                    }
                }
                ToolbarItem(placement: .principal) {
                    switch viewModel.mode {
                    case .createNewTask:
                        Text("Create New Task").bold()
                    case .editExistingTask(_):
                        Text("Edit Task").bold()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.onSaveButtonTapped()
                    }
                }
            }
            .foregroundColor(Color(.primaryAccent))
            .alert(item: $viewModel.error, content: { error in
                switch error {
                case .invalidTitle:
                    return Alert(title: Text("Error"), message: Text("Title cannot be left empty."))
                case .createTaskError:
                    return Alert(title: Text("Error"), message: Text("Task cannot be saved."))
                case .updateTaskError:
                    return Alert(title: Text("Error"), message: Text("Edit cannot be saved."))
                }
            })
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(viewModel: CreateTaskViewModel(
            taskService: FeaturesToDo(),
            mode: .editExistingTask(TaskModel(title: "Hi", deadline: Date())),
            onCancelled: {},
            onSaved: {}
        ))
    }
}
