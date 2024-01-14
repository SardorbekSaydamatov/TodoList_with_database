//
//  LoginView.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 20/10/23.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @EnvironmentObject private var listViewModel2: ListViewModel
    @State private var emailTapped = false
    @State private var passwordTapped = false
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var isAuthenticated = false
   // @State private var registerPresented = false
    
    var listViewModel: ListViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to\nTask Manager")
                    .font(
                        Font.custom("SF Pro Rounded", size: 24)
                            .weight(.semibold)
                    )
                
                textFields
                
                signInButton
                
                HStack {
                    Rectangle()
                        .frame(width: 155, height: 1)
                    Text("or")
                    Rectangle()
                        .frame(width: 155, height: 1)
                }
                .padding(.top, 20)
                
                NavigationLink("Register", destination: RegisterVIew())
                    .font(
                        Font.custom("SF Compact Display", size: 12)
                            .weight(.semibold)
                    )
                    .foregroundStyle(Color.init(uiColor: .label))
                    .padding(.leading, 145)
                    .padding(.top, 30)
            }
            .background(content:{Color.init(.systemBackground)})
        }
        .fullScreenCover(isPresented: $isAuthenticated, content: {
            TasksView()
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Authentication Failed"),
                message: Text("Incorrect email or password. Please try again."),
                dismissButton: .default(Text("OK"))
            )
        }
        .background(content:{Color.init(uiColor: .systemBackground)})
        .padding(.horizontal)
    }
    
    private var textFields: some View {
        VStack(spacing: 16) {
            HStack {
                Image("human")
                    .padding(.leading)
                TextField("Email", text: $email)
            }
            .frame(width: 335, height: 50)
            .background(Color.init(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
            .padding(.top, 30)
            
            HStack {
                Image("key")
                    .padding(.leading)
                SecureField("Password", text: $password)
            }
            .frame(width: 335, height: 50)
            .background(Color.init(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
        }
        
    }
    
    private var signInButton: some View {
        Button(action: {
            listViewModel.signIn(email: email, password: password) { success in
                if success {
                    isAuthenticated = true
                } else {
                    showAlert = true
                }
            }
        }, label: {
            Text("Sign in")
        })
        .frame(width: 335 ,height: 50)
        .background(content:{Color.init(uiColor: .secondarySystemBackground)})
        .foregroundStyle(Color.init(uiColor: .label))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top, 40)
    }
}

#Preview {
    LoginView(listViewModel: ListViewModel())
}
