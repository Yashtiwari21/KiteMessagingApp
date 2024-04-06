//
//  GroupTableCell.swift
//  KiteApp
//
//  Created by Admin on 21/03/24.
//

import UIKit

class GroupTableCell: UITableViewCell {
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personStatus: UILabel!
    @IBOutlet weak var selectBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectBox.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
