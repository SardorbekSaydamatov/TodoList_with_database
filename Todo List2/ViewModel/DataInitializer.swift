//
//  DataInitializer.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 26/10/23.
//

import Foundation
import RealmSwift


class DataService {
    static let shared = DataService()
    
    private init() {
        initializeRealm()
        // initializeDefaultUsers()
    }
    
    func initializeRealm() {
        var config = Realm.Configuration()
        config.schemaVersion = 6 // Set the schema version to a higher value than the previous version
        config.migrationBlock = { migration, oldSchemaVersion in
            // Handle any necessary data migrations here
        }
        Realm.Configuration.defaultConfiguration = config
    }
}
//
//        do {
//            let _ = try Realm()
//        } catch {
//            debugPrint("Error initializing Realm: \(error.localizedDescription)")
//        }
//    }
//    
//    func initializeDefaultUsers() {
//        Realm.new?.tryWrite { realm in
//            let user1 = User(id: UUID().uuidString, firstName: "John", lastName: "Doe", email: "Test@1.com", password: "password1")
//            let user2 = User(id: UUID().uuidString, firstName: "Jane", lastName: "Smith", email: "Test@2.com", password: "password2")
//            
//            realm.add(user1)
//            realm.add(user2)
//        }
//    }
//}
