//
//  BoolCell.swift
//  To Do List 
//
//  Created by Viktor on 02/05/2019.
//  Copyright © 2019 Chernykh Viktor. All rights reserved.
//

import UIKit

class BoolCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    weak var delegate: CellActionDelegate?
    var section: Int!
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        delegate?.cell(switchToggled: `switch`, forSection: section)
    }
}
