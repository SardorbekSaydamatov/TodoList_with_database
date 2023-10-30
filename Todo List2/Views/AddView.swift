//
//  AddView.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var newTask = ""
    @Environment(\.presentationMode) var dismiss
    @State private var selectedDate = Date()
    @State private var datePickerPresented = false
    var body: some View {
        NavigationView(content: {
            VStack {
                textField
                
                Spacer()
                
                Button(action: {
                    datePickerPresented.toggle()
                }, label: {
                    Text("Pick a date")
                        .font(Font.custom("Raleway", size: 14).weight(.medium))
                        .foregroundStyle(Color.init(uiColor: .label))
                })
                .frame(width: 335, height: 50)
                .background(content:{Color.init(uiColor: .secondarySystemBackground)})
                .clipShape(.rect(cornerRadius: 8))
                .padding()
            }
            .background(content: {Color.init(uiColor: .systemBackground)})
            .navigationTitle("Add Task")
            .font(
                Font.custom("SF Pro Text", size: 16)
                .weight(.semibold))
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $datePickerPresented, content: {
                VStack {
                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .presentationDetents([.height(400)])
                    
                    Button {
                        saveButtonPressed()
                        dismiss.wrappedValue.dismiss()
                    } label: {
                        Text("Add")
                            .font(Font.custom("Raleway", size: 14).weight(.medium))
                            .frame(width: 335, height: 50)
                            .background(content:{Color.init(uiColor: .secondarySystemBackground)})
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.init(uiColor: .label))
                .background(Color.init(uiColor: .secondarySystemBackground))
                .foregroundStyle(Color.orange)
            })
            .navigationBarTitle("Add Task", displayMode: .inline).font(Font.custom("SF Pro Text", size: 16).weight(.semibold))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 11.97656, height: 20.78906)
                            .foregroundStyle(Color.init(uiColor: .label))
                    })
                }
            }
        })
    }
    
    private var textField: some View {
        TextField("", text: $newTask, prompt: Text("Enter a task").foregroundStyle(Color.gray), axis: .vertical)
            .lineLimit(8, reservesSpace: true)
            .font(Font.custom("Raleway", size: 14))
            .padding()
            .background(content: {Color.init(uiColor: .secondarySystemBackground)})
            .clipShape(.rect(cornerRadius: 10))
            .padding()
    }
    
    private func saveButtonPressed() {
         if !newTask.isEmpty {
             let currentDate = Date()
             let newTaskDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: currentDate), minute: Calendar.current.component(.minute, from: currentDate), second: 0, of: selectedDate) ?? selectedDate
             listViewModel.addItem(title: newTask, dateAdded: newTaskDate, fromUser: UserDefaults.standard.string(forKey: "userName")!)
             newTask = ""
         }
     }
}

//#Preview {
//    AddView()
//}
