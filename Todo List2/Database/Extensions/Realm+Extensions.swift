//
//  Realm+Extensions.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import Foundation
import RealmSwift

extension Realm {
    static var new: Realm? {
        try? Realm()
    }
    
    func tryWrite(_ block: @escaping (Realm) -> Void) {
        do {
            try self.write({
                block(self)
            })
        } catch {
            debugPrint("Cannot write \(error.localizedDescription)")
        }
    }
}
