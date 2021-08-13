//
//  DateExtension.swift
//  Weather
//
//  Created by Admin on 12.08.2021.
//

import Foundation

public extension Date {
    
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    
    func hour(using calendar: Calendar = .current) -> Int {
        return calendar.component(.hour, from: self)
    }
}
