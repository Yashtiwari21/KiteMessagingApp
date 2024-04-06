//
//  ChatTableCell.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class ChatTableCell: UITableViewCell {
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatUserName: UILabel!
    @IBOutlet weak var chatUserTime: UILabel!
    @IBOutlet weak var chatUserDesc: UILabel!
    @IBOutlet weak var callTypeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
