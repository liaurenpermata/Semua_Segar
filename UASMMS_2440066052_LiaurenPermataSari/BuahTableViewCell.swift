//
//  BuahTableViewCell.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 03/02/23.
//

import UIKit

class BuahTableViewCell: UITableViewCell {
    
    
    @IBOutlet var buahGenus: UILabel!
    @IBOutlet var buahTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
