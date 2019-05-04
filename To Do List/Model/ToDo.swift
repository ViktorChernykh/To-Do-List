//
//  ToDo.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

@objcMembers class ToDo: NSObject {
    // MARK: - Stored Properties
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    var image: UIImage?
    
    // MARK: - Initializeers
    init(
        title: String = String(),
        isComplete: Bool = Bool(),
        dueDate: Date = Date(),
        notes: String? = String(),
        image: UIImage? = UIImage()
    ) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        self.image = image
    }
    
    // MARK: - Computed Properties
    var capitalizedKeys: [String] {
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any?] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
    // MARK: - Methods
    static func loadData() -> [ToDo]? {
        return loadSampleData()
    }
    
    static func loadSampleData() -> [ToDo] {
        return [
            ToDo(title: "Купить хлеб", isComplete: false, dueDate: Date(), notes: "В Пятёрочке", image: UIImage(named: "bread")),
            ToDo(title: "Поздравить с 1 мая", isComplete: false, dueDate: Date(), notes: "Купить шарики", image: UIImage(named: "shary")),
            ToDo(title: "Выехать за город", isComplete: false, dueDate: Date(), notes: "Взять мангал", image: UIImage(named: "nature")),
        ]
    }
}

extension ToDo: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let todo = ToDo()
        
        keys.forEach {
            let value = self.value(forKey: $0)
            todo.setValue(value, forKey: $0)
        }
        
        return todo
    }
}
