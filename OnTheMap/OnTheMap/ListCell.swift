//
//  ListCell.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 16/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    
    @IBOutlet weak var imagePin: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    func setup() {
        self.label.text = "Name of the User"
    }

}
