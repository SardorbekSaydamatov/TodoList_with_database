//
//  ContentView.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 31/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var listViewModel: ListViewModel
    var body: some View {
        if listViewModel.isUserLoggedIn {
            TasksView()
        } else {
            LoginView(listViewModel: listViewModel)
        }
    }
}

#Preview {
    ContentView()
}
