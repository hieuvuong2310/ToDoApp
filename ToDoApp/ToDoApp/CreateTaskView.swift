//
//  CreateTaskView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-01.
//

import Foundation
import SwiftUI

struct CreateTaskView: View {
    @StateObject private var createTaskViewModel = CreateTaskViewModel()
   var body: some View {
       VStack(spacing: 15) {
           NavigationStack{
               VStack(alignment: .leading, spacing: 15){
                   Text("Task Title")
                       .multilineTextAlignment(.leading)
                   TextField("Insert Title", text: $createTaskViewModel.titleInput)
                       .padding(.leading, 10.0)
                     .textInputAutocapitalization(.words)
                     .frame(width: 390.0, height: 40)
                     .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.accentColor, lineWidth: 2)
                     )
                   Spacer()
                       .frame(height: 15)
                   Text("Date of Completion")
                   Button("Choose Date"){
                       //Current stuck here, don't know how to click this button to open the date picker widget
                   }
                       .frame(width: 390.0, height: 40.0, alignment:Alignment.leading)
                       .foregroundColor(Color.gray)
                       .overlay(
                          RoundedRectangle(cornerRadius: 14)
                              .stroke(Color.accentColor, lineWidth: 2)
                       )
               }
               .toolbar{
                   ToolbarItemGroup(placement: .navigationBarLeading){
                       NavigationLink(destination: ContentView(), label: {
                           Text("Cancel")
                       }).padding()
                       Text("Create New Task").bold().padding()
                       Button("Save"){
                           createTaskViewModel.title = createTaskViewModel.titleInput
                           createTaskViewModel.titleInput = ""
                       }.padding()
                   }
               }
           }
       }
       .padding()
   }
}
struct CreateTaskView_Previews: PreviewProvider {
   static var previews: some View {
      CreateTaskView()
   }
}
