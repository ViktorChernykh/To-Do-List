//
//  DateCell.swift
//  To Do List
//
//  Created by Viktor on 03/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CellActionDelegate?
    var section: Int!
    
    @IBAction func choiceToDoDate(_ sender: UIDatePicker) {
        delegate?.cell(choiceToDoDate: sender, forSection: section)
    }
    
}
