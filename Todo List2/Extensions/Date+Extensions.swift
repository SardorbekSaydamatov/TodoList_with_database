//
//  Date+Extensions.swift
//  Todo List2
//
//  Created by Sardorbek Saydamatov on 18/10/23.
//

import Foundation

extension Date {
    func isInSameDay(withDate date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}
