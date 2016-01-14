//
//  DiscountCell.swift
//  CardMaster
//
//  Created by Jue Wang on 9/20/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class DiscountCell: UITableViewCell {
    
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var Discount: UILabel!
    @IBOutlet weak var StartDate: UILabel!
    @IBOutlet weak var ExpireDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}