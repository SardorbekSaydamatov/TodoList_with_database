//
//  DToDo.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import Foundation
import RealmSwift

class DToDo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String // uuid string
    @Persisted var details: String
    @Persisted var createdDate: Date
    @Persisted var isCompleted: Bool
    @Persisted var fromUser: String
    
    init(id: String, details: String, createdDate: Date, fromUser: String) {
        self.details = details
        self.createdDate = createdDate
        self.isCompleted = false
        self.fromUser = fromUser
        super.init()
        self.id = id
    }

    override init() {
        super.init()
    }
    
    func set(isCompleted: Bool) {
        self.isCompleted = isCompleted
    }
}

class User: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var email: String
    @Persisted var password: String
    
    init(id: String, firstName: String, lastName: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        super.init()
        self.id = id
    }
    
    override init() {
        super.init()
    }
}
