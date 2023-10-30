//
//  ListViewModel.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import Foundation
import RealmSwift

class ListViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    func authenticateUser(email: String, password: String) -> Bool {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self).filter("email == %@ AND password == %@", email, password)
            
            if let user = users.first {
                UserDefaults.standard.set(true, forKey: "LoggedIn")
                UserDefaults.standard.set(user.id, forKey: "userName")
                isAuthenticated = true
                return true
            } else {
                isAuthenticated = false
                return false
            }
        } catch {
            debugPrint("Error accessing Realm database when calling authenticateUser: \(error.localizedDescription)")
            return false
        }
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "LoggedIn")
        UserDefaults.standard.removeObject(forKey: "userName")
        isAuthenticated = false
    }
    
        
    func registerUser(firstName: String, lastName: String, email: String, password: String) -> Bool {
        do {
            let realm = try Realm()
            let existingUser = realm.objects(User.self).filter("email == %@", email)
            if existingUser.isEmpty {
                let newUser = User()
                newUser.id = UUID().uuidString
                newUser.firstName = firstName
                newUser.lastName = lastName
                newUser.email = email
                newUser.password = password
                
                try realm.write {
                    realm.add(newUser)
                }
                return true
            }
        } catch {
            debugPrint("Error accessing Realm database: \(error.localizedDescription)")
        }
        return false
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
