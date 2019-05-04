//
//  CellActionDelegate.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

protocol CellActionDelegate: class {
    func cell(editingEnded textField: UITextField, forSection section: Int)
    func cell(textChanged textField: UITextField, forSection section: Int)
    func cell(switchToggled `switch`: UISwitch, forSection section: Int)
    func cell(choiceToDoDate: UIDatePicker, forSection section: Int)
    func cell(choiceToDoImage imageView: UIImageView, forSection section: Int)
}
