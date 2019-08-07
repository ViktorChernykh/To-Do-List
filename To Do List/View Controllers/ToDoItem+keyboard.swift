//
//  ToDoItem+keyboard.swift
//  To Do List
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import  UIKit

// MARK: - Text Field Delegate
extension ToDoItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ToDoItemViewController {
    
    func addTapGestureToHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

