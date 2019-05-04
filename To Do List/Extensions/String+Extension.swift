//
//  String+Extension.swift
//  To Do List
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

extension String {
    var capitalizedWithSpaces: String {
        let withSpaces = self.reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
        }
        
        return withSpaces.capitalized
    }
}
