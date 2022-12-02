//
//  DatePicker.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-01.
//

import Foundation
import SwiftUI

struct DatePicker: View {
    @State private var selectedDates: Set<DateComponents> = []
    @State private var mydates: String = ""
    
    var body: some View {
        VStack {
            MultiDatePicker("Dates:", selection: $selectedDates)
           Spacer()
            Text(mydates)
        }.padding()
            .onChange(of: selectedDates) { values in
           let days = values.map({ value in String(value.day!) })
                mydates = days.joined(separator: ",")
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker()
    }
}

