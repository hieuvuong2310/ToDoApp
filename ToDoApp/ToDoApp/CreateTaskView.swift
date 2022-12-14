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
    @State var titleInput: String = ""
    @State var date: Date = Date()
    init(viewModel: CreateTaskViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 21) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Task Name")
                        .foregroundColor(Color(.primaryText))
                    TextField("Insert Title", text: $titleInput)
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
                    DatePicker(selection: $date) {
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
                    Text("Create New Task").bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.onSaveButtonTapped(inputTitle: self.titleInput, date: self.date)
                    }
                }
            }
            .foregroundColor(Color(.primaryAccent))
            .alert(item: $viewModel.error, content: { error in
                switch error {
                case .invalidTitle:
                    return Alert(title: Text("Error"), message: Text("Title cannot be left empty."))
                }
            })
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(viewModel: CreateTaskViewModel(
            taskService: FeaturesToDo(),
            onCancelled: {},
            onSaved: {}
        ))
    }
}
