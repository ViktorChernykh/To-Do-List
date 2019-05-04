//
//  Date+Extension.swift
//  To Do List
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
