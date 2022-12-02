//
//  CreateTaskView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-02.
//

import Foundation
import SwiftUI

struct CreateTaskView: View {
    @StateObject private var createTaskViewModel = CreateTaskViewModel()
    @State var titleInput: String = ""
    @State var showDatePicker = false
    @State var chooseDateTitle: String = "Choose date"
    @State var date: Date = Date()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("Task Title")
                    .multilineTextAlignment(.leading)
                TextField("Insert Title", text: $titleInput)
                    .padding(.horizontal, 10.0)
                    .textInputAutocapitalization(.words)
                    .frame(maxWidth: 390, maxHeight: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                Text("Date of Completion")
                Text(self.chooseDateTitle)
                .onTapGesture {
                    self.showDatePicker.toggle()
                }
                .frame(maxWidth: 390, maxHeight: 50, alignment: Alignment.leading)
                .foregroundColor(Color.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.accentColor, lineWidth: 2)
                )
                if self.showDatePicker {
                    DatePicker("Enter your Deadline", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(maxWidth: 390, maxHeight: 400)
                        .onTapGesture {
                            self.showDatePicker.toggle()
                            self.chooseDateTitle = self.date.description
                        }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(id: "cancel", placement: .navigationBarLeading) {
                    Button("Cancel") {
                        createTaskViewModel.onCancelButtonTapped()
                    }
                }
                ToolbarItem(id: "create-title", placement: .principal) {
                    Text("Create New Patient").bold()
                }
                ToolbarItem(id: "save", placement: .navigationBarTrailing) {
                    Button("Save") {
                        createTaskViewModel.onSaveButtonTapped(inputTitle: self.titleInput, date: self.date)
                    }
                }
            }
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
   static var previews: some View {
      CreateTaskView()
   }
}
