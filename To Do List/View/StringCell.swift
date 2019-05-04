//
//  StringCell.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class StringCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: CellActionDelegate?
    var section: Int!
    
    @IBAction func editingEnded(_ sender: UITextField) {
        delegate?.cell(editingEnded: sender, forSection: section)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        delegate?.cell(textChanged: sender, forSection: section)
    }
}
