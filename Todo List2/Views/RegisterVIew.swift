//
//  RegisterVIew.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 29/10/23.
//

import SwiftUI

struct RegisterVIew: View {
    @State private var userName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var passwod: String = ""
    @State private var registrationSucceded = false
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listVIewModel: ListViewModel
    var body: some View {
            VStack {
                
                textFields
                    .padding(.top, 60)
                Spacer()
                signUpButton
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.init(uiColor: .label))
                    })
                }
            })
            .fullScreenCover(isPresented: $registrationSucceded, content: {
                TasksView()
            })
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .background(content:{Color.init(.systemBackground)})
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Registration Error"),
                    message: Text("Registration failed. Please check your information."),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    private var textFields: some View {
        VStack(spacing: 16) {
            TextField("First name", text: $userName)
                .padding(.leading)
                .frame(width: 335, height: 50)
                .background(Color.init(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            TextField("Last name", text: $lastName)
                .padding(.leading)
                .frame(width: 335, height: 50)
                .background(Color.init(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            TextField("Email", text: $email)
                .padding(.leading)
                .frame(width: 335, height: 50)
                .background(Color.init(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            SecureField("Password", text: $passwod)
                .padding(.leading)
                .frame(width: 335, height: 50)
                .background(Color.init(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
        }
    }
    
    private var signUpButton: some View {
        
        VStack {
            Button(action: {
                if listVIewModel.registerUser(firstName: userName, lastName: lastName, email: email, password: passwod) {
                    registrationSucceded = true
                    userName = ""
                    lastName = ""
                    email = ""
                    passwod = ""
                } else {
                    showingAlert = true
                    userName = ""
                    lastName = ""
                    email = ""
                    passwod = ""
                }
            }, label: {
                Text("Sign up")
            })
            .frame(width: 335 ,height: 50)
            .background(content:{Color.init(uiColor: .secondarySystemBackground)})
            .foregroundStyle(Color.init(uiColor: .label))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    RegisterVIew()
}
