//
//  CardCell.swift
//  CardMaster
//
//  Created by Jue Wang on 9/19/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var CardName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
