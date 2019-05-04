//
//  ToDoItemViewController.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class ToDoItemViewController: UITableViewController {
    
    let configurator = Configurator()
    var isCancelled = false
    var todo = ToDo()
    var originalTodo: ToDo!
    var imageView: UIImageView!
}

// MARK: - CellActionDelegate
extension ToDoItemViewController: CellActionDelegate {
    
    func cell(editingEnded textField: UITextField, forSection section: Int) {
        updateFromField(textField, forSection: section)
    }
    
    func cell(switchToggled switch: UISwitch, forSection section: Int) {
        if !isCancelled {
            let key = todo.keys[section]
            let isSet = `switch`.isOn
            todo.setValue(isSet, forKey: key)
        }
        isCancelled = false
    }
    
    func cell(textChanged textField: UITextField, forSection section: Int) {
        updateFromField(textField, forSection: section)
    }
    
    func cell(choiceToDoDate datePicker: UIDatePicker, forSection section: Int) {
        updateFromDate(datePicker, forSection: section)
    }
    
    func cell(choiceToDoImage imageView: UIImageView, forSection section: Int) {
        self.imageView = imageView
        
        if !isEditing {
            setEditing(true, animated: true)
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = self.imageView.frame
        present(alertController, animated: true)

        updateImage(imageView, forSection: section)
    }
}

// MARK: - Methods
extension ToDoItemViewController {
    @objc func cancelButtonTapped() {
        todo = originalTodo!.copy() as! ToDo
        isCancelled = true
        setEditing(false, animated: true)
    }
    
    @objc func saveButtonTapped() {
        performSegue(withIdentifier: "UnwindSegue", sender: nil)
    }
    
    func updateFromField(_ textField: UITextField, forSection section: Int) {
        if !isCancelled {
            let key = todo.keys[section]
            let text = textField.text ?? ""
            todo.setValue(text, forKey: key)
        }
        isCancelled = false
    }
    func updateFromDate(_ datePicker: UIDatePicker, forSection section: Int) {
        if !isCancelled {
            let key = todo.keys[section]
            let date = datePicker.date
            todo.setValue(date, forKey: key)
        }
        isCancelled = false
    }
    
    func updateImage(_ imageView: UIImageView, forSection section: Int) {
        if !isCancelled {
            let key = todo.keys[section]
            let image = imageView.image
            todo.setValue(image, forKey: key)
        }
        isCancelled = false
    }
}

// MARK: - UITableViewDateSource
extension ToDoItemViewController /*: UITableViewDateSource */ {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todo.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = todo.capitalizedKeys[section]
        return key
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        let cell = configurator.getCell(in: self, forSection: section)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let autoHeight = UITableView.automaticDimension
        
        switch indexPath {
        case IndexPath(row: 0, section: 2):     // cell with datePicker
            return isEditing ? autoHeight : 44
        case IndexPath(row: 0, section: 4):     // cell with image
            return 200
        default:
            return autoHeight
        }
    }
}

// MARK: - UITableViewDelegate
extension ToDoItemViewController /*: UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !isEditing {
            setEditing(true, animated: true)
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isCancelled && !isEditing {
            let translationTransform = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 1)
            cell.layer.transform = translationTransform
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                cell.layer.transform = CATransform3DIdentity
            })
        }
    }
}

// MARK: - UIViewController Methods
extension ToDoItemViewController {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        }

        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        originalTodo = todo.copy() as? ToDo
        navigationItem.rightBarButtonItem = editButtonItem
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ToDoItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let data = info[UIImagePickerController.InfoKey.originalImage] else { return }
        let image = (data as? UIImage)!
        imageView.image = image
        updateImage(imageView, forSection: 4)
        dismiss(animated: true)
    }
}
