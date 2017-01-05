//
//  CustomTableViewCell.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 5/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabelView: UILabel!
    
    @IBOutlet weak var authorsLabelView: UILabel!
    
    
    @IBOutlet weak var tagLabelView: UILabel!
    
    
    @IBOutlet weak var imgView: UIImageView!
   
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
