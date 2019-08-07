//
//  ToDoTableViewController.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    let configurator = Configurator()
    
    var todos: [ToDo]!
}

// MARK: - Navigation
extension ToDoTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let todo = todos[indexPath.row]
        let controller = segue.destination as! ToDoItemViewController
        
        controller.navigationItem.title = "Edit"
        controller.todo = todo
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "UnwindSegue" else { return }
        let todo = (segue.source as! ToDoItemViewController).todo
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            todos[selectedIndex.row] = todo
            tableView.reloadRows(at: [selectedIndex], with: .automatic)
        } else {
            let indexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableViewDataSource
extension ToDoTableViewController /*: UITableViewDataSource */ {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")!
        let todo = todos[indexPath.row]
        
        configurator.configure(cell, with: todo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
}

// MARK: - UIViewController Methods
extension ToDoTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todos = ToDo.loadData() {
            self.todos = todos
        } else {
            self.todos = ToDo.loadSampleData()
        }
    }
}

