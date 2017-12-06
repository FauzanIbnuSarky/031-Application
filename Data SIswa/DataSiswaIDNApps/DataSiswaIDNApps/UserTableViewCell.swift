//
//  UserTableViewCell.swift
//  DataSiswaIDNApps
//
//  Created by Nando Septian Husni on 18/11/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
