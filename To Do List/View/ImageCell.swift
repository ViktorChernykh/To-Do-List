//
//  ImageCell.swift
//  To Do List
//
//  Created by Viktor on 03/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var toDoImageView: UIImageView!
    
    weak var delegate: CellActionDelegate?
    var section: Int!

    @IBAction func buttonAtion(_ sender: UIButton) {
        delegate?.cell(choiceToDoImage: toDoImageView, forSection: section)
    }
}
