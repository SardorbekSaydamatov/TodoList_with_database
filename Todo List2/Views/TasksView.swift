//
//  ContentView.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 17/10/23.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @Environment (\.dismiss) var dismiss
    @ObservedResults(DToDo.self) var tasks
    @Environment(\.colorScheme) var colorScheme
    @State private var datePresented = false
    @State private var isPresented = false
    @State private var temporaryDate = Date()
    @State private var selectedDate = Date()
    @State private var taskCheck = false
    
    var weekDay: String {
        let calendar = Calendar.current
            
            let selectedDay = calendar.startOfDay(for: selectedDate)
            
            if calendar.isDateInToday(selectedDay) {
                return "Today"
            } else if calendar.isDateInTomorrow(selectedDay) {
                return "Tomorrow"
            } else if calendar.isDateInYesterday(selectedDay) {
                return "Yesterday"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE" // Use full weekday name
                return dateFormatter.string(from: selectedDate)
            }
    }
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: selectedDate)
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    var body: some View {
        VStack {
            headerView
            
            ZStack {
                taskListView
                    .padding(.top, 20)
                Button(action: {
                    isPresented = true
                }, label: {
                    Image("vector2")
                        .frame(width: 14, height: 14)
                })
                .frame(width: 50, height: 50)
                .background(Color.init(uiColor: .opaqueSeparator))
                .clipShape(Circle())
                .padding(.leading, 300)
                .padding(.top, 600)
            }
        }
        .background(content:{Color.init(uiColor: .systemBackground)
                .ignoresSafeArea()
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Todo List").font(
            Font.custom("Raleway", size: 14)
                .weight(.semibold)
        )
        .sheet(isPresented: $datePresented) {
            VStack {
                DatePicker("", selection: $temporaryDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .presentationDetents([.height(400)])
                    .foregroundStyle(Color.white)
                    .colorInvert()
                    .colorMultiply(Color.white)
                
                
                Button("Submit") {
                    selectedDate = temporaryDate
                    datePresented.toggle()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.init(uiColor: .label))
            .foregroundStyle(Color.orange)
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            AddView()
        })
    }
    
    private var headerView: some View {
            HStack(spacing: 240) {
                VStack(alignment: .leading) {
                    Text(weekDay)
                        .padding(.bottom, 5)
                    Text(currentDate)
                        .foregroundStyle(Color.init(uiColor: .secondaryLabel))
                }
                VStack {
                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: "userID")
                            listViewModel.logout()
                            dismiss()
                        }, label: {
                            Image("exit")
                                .foregroundStyle(Color.red)
                        })
                    
                    Button {
                        datePresented.toggle()
                    } label: {
                        Image("vector")
                            .frame(width: 24)
                            .colorMultiply(colorScheme == .dark ? Color.init(uiColor: .label) : Color.init(uiColor: .label))
                    }
                }
            }
            .padding(.top, 40)
    }
    
    
    private var taskListView: some View {
        ScrollView {
            if tasks.filter({ task in
                return task.createdDate.isInSameDay(withDate: self.selectedDate)
            }).isEmpty {
                Text("No Tasks")
                    .font(
                        Font.custom("Raleway", size: 24)
                            .weight(.black)
                    )
                    .foregroundStyle(Color.init(uiColor: .secondaryLabel))
                    .padding(.top, 200)
            } else {
                ForEach(
                    tasks.filter { task in
                        return task.createdDate.isInSameDay(withDate: self.selectedDate) && task.fromUser == UserDefaults.standard.string(forKey: "userID")
                    }.sorted(by: {
                        $0.isCompleted.value < $1.isCompleted.value
                    })
                ) { task in
                    taskItem(
                        task
                    )
                }
            }
        }
    }
    
    private func taskItem(_ item: DToDo) -> some View {
        
        return GeometryReader { geometry in
                HStack {
                    Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                        .foregroundStyle(
                            item.isCompleted ? Color.init(uiColor: .secondaryLabel) : Color.init(uiColor: .label)
                        )
                    
                    Text(item.details)
                        .font(Font.custom("Raleway", size: 14))
                        .foregroundStyle(
                            item.isCompleted ? Color.secondary : Color.init(uiColor: .label)
                        )
                        .strikethrough(item.isCompleted, color: Color.init(uiColor: .secondaryLabel))
                    
                    Spacer()
                    
                    Text(dateFormatter.string(from: item.createdDate))
                        .font(Font.custom("Raleway", size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.init(uiColor: .secondaryLabel))
                        .frame(width: 53, height: 14, alignment: .center)
                        .padding(.trailing)
                }
                .padding(.top, 20)
                .padding(.leading, 20)
        }
        .frame(height: 60)
        .background(Color.init(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 10)
        .onTapGesture {
            listViewModel.updateItem(item: item)
        }
    }
}

#Preview {
    TasksView()
}

