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
            VStack(alignment: .leading, spacing: 21) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Task Title")
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 20.0)
                    TextField("Insert Title", text: $titleInput)
                        .padding(.horizontal, 10.0)
                        .textInputAutocapitalization(.words)
                        .frame(minHeight: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 1)
                    )
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of Completion")  
                    DatePicker(selection: $date) {
                        Text("Select date")
                    }
                    .padding(.horizontal)
                    .frame(minHeight: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
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
                    Text("Create New Patient").bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
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
