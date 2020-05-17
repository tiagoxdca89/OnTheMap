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
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    func setup() {
        self.title.text = "Name of the User"
        self.subTitle.text = "https://udacity.com"
    }

}
