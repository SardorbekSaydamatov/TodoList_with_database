//
//  ListViewModel.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import Foundation
import RealmSwift
import Firebase

class ListViewModel: ObservableObject {
    @Published var isUserLoggedIn = false
    @Published var user: User?
    @Published var registrationSucceeded = false
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                completion(false)
            } else {
                self.isUserLoggedIn = true
                if let user = authResult?.user {
                    UserDefaults.standard.set(user.uid, forKey: "userID")
                    debugPrint("********* \(UserDefaults.standard.string(forKey: "userID"))")
                    completion(true)
                }
            }
        }
    }

    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error registering: \(error.localizedDescription)")
                completion(false)
            } else if let user = authResult?.user {
                self.user = User(id: user.uid, firstName: firstName, lastName: lastName, email: email)
                UserDefaults.standard.set(user.uid, forKey: "userID")
               
                completion(true)
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func addItem(title: String, dateAdded: Date, fromUser: String) {
        
        Realm.new?.tryWrite { realm in
            let item = DToDo(id: UUID().uuidString, details: title, createdDate: dateAdded, fromUser: fromUser)
            realm.add(item)
        }
    }
    
    func updateItem(item: DToDo) {
        let itemId = item.id
        Realm.new?.tryWrite({ realm in
            if let _item = realm.object(ofType: DToDo.self, forPrimaryKey: itemId) {
                _item.set(isCompleted: !_item.isCompleted)
            }
        })
    }
}
