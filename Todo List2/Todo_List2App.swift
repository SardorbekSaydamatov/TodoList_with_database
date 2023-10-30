//
//  Todo_List2App.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 17/10/23.
//

import SwiftUI

@main
struct Todo_List2App: App {
    @StateObject private var listViewModel = ListViewModel()
    
    let dataService = DataService.shared
    
    init() {
            dataService.initializeDefaultUsers()
        debugPrint("Test")
        }
    
    var body: some Scene {
        WindowGroup {
            
            if UserDefaults.standard.bool(forKey: "LoggedIn") {
                TasksView()
                    .environmentObject(listViewModel)
            } else {
                LoginView(listViewModel: listViewModel)
                    .environmentObject(listViewModel)
            }
            
        }
    }
}
