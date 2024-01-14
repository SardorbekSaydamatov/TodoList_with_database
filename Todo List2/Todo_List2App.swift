//
//  Todo_List2App.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 17/10/23.
//

import SwiftUI
import Firebase

@main
struct Todo_List2App: App {
    @StateObject private var listViewModel = ListViewModel()
    let dataService = DataService.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    Auth.auth().addStateDidChangeListener {  auth, user in
                        if let user = user {
                            listViewModel.user = User(id: user.uid, firstName: "", lastName: "", email: user.email!)
                            listViewModel.isUserLoggedIn = true
                        } else {
                            listViewModel.user = nil
                            listViewModel.isUserLoggedIn = false
                        }
                    }
                })
                .environmentObject(listViewModel)
        }
    }
}
