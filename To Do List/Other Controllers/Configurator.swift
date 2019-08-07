//
//  Configurator.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class Configurator {
    
    func configure(_ cell: UITableViewCell, with todo: ToDo) {
        cell.detailTextLabel?.text = todo.dueDate.formatted
        cell.textLabel?.text = todo.title
        cell.imageView?.image = todo.image
    }

    func getCell(in controller: ToDoItemViewController, forSection section: Int) -> UITableViewCell {
        let value = controller.todo.values[section]
        
        if let value = value as? String {
            return getCell(with: value, in: controller, forSection: section)
        } else if let value = value as? Bool {
            return getCell(with: value, in: controller, forSection: section)
        } else if let value = value as? Date {
            return getCell(with: value, in: controller, forSection: section)
        } else if let value = value as? UIImage {
            return getCell(with: value, in: controller, forSection: section)
        } else {
            return UITableViewCell()
        }
    }
    
    func getCell(with value: String, in controller: ToDoItemViewController, forSection section: Int) -> UITableViewCell {
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "StringCell")! as! StringCell
        
        cell.delegate = controller
        cell.section = section
        
        if controller.isEditing {
            cell.label.isHidden = true
            cell.textField.isHidden = false
            cell.textField.text = value
        } else {
            cell.label.isHidden = false
            cell.label.text = value
            cell.textField.isHidden = true
        }
        
        return cell
    }
    
    func getCell(with value: Bool, in controller: ToDoItemViewController, forSection section: Int) -> UITableViewCell {
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "BoolCell")! as! BoolCell
        
        cell.delegate = controller
        cell.section = section
        
        if controller.isEditing {
            cell.label.isHidden = true
            cell.`switch`.isHidden = false
            cell.`switch`.isOn = value
        } else {
            cell.label.isHidden = false
            cell.label.text = value ? "On" : "Off"
            cell.`switch`.isHidden = true
        }
        
        return cell
    }
    
    func getCell(with value: Date, in controller: ToDoItemViewController, forSection section: Int) -> UITableViewCell {
        
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "DateCell")! as! DateCell
        cell.delegate = controller
        cell.section = section
        
        if controller.isEditing {
            cell.dateLabel.isHidden = true
            cell.datePicker.isHidden = false
            cell.datePicker.date = value
        } else {
            cell.dateLabel.isHidden = false
            cell.datePicker.isHidden = true
            cell.dateLabel.text = value.formatted
        }
        cell.datePicker.minimumDate = Date()

        return cell
    }
    
    func getCell(with value: UIImage, in controller: ToDoItemViewController, forSection section: Int) -> UITableViewCell {
        
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "ImageCell")! as! ImageCell
        cell.delegate = controller
        cell.section = section
        cell.toDoImageView.image = value
        return cell
    }
}
