//
//  WalkRecordTableViewCell.swift
//  PetPet
//
//  Created by nttr on 2019/01/28.
//  Copyright © 2019年 nttr.inc. All rights reserved.
//

import UIKit

    class WalkRecordTableViewCell: UITableViewCell {
        
        @IBOutlet var timeLabel: UILabel!
        @IBOutlet var userNameLabel: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
        
        
}
