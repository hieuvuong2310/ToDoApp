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
    @StateObject private var createTaskViewModel = CreateTaskViewModel()
    @State var titleInput: String = ""
    @State var date: Date = Date()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 21) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Task Name")
                        .foregroundColor(Color(ColorStyle.primaryText))
                    TextField("Insert Title", text: $titleInput)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.words)
                        .frame(minHeight: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(ColorStyle.secondaryAccent), lineWidth: 1)
                        )
                        .introspectTextField(customize: {
                                $0.clearButtonMode = .whileEditing
                        })
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of Completion")
                        .foregroundColor(Color(ColorStyle.primaryText))
                    DatePicker(selection: $date) {
                        Text("Select date")
                            .foregroundColor(Color(ColorStyle.primaryText))
                    }
                    .padding(.horizontal, 16.0)
                    .frame(minHeight: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(ColorStyle.secondaryAccent), lineWidth: 1)
                    )
                    .tint(Color(ColorStyle.secondaryAccent))
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        createTaskViewModel.onCancelButtonTapped()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Create New Task").bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        createTaskViewModel.onSaveButtonTapped(inputTitle: self.titleInput, date: self.date)
                    }
                }
            }
            .foregroundColor(Color(ColorStyle.primaryAccent))
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
   static var previews: some View {
      CreateTaskView()
   }
}
