//
//  LikeTableViewCell.swift
//  UASMMS_2440066052_LiaurenPermataSari
//
//  Created by prk on 08/02/23.
//

import UIKit

class LikeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var buahLike: UILabel!
    @IBOutlet weak var personLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
