//
//  SelectedMemberTableCell.swift
//  KiteApp
//
//  Created by Admin on 02/04/24.
//

import UIKit

protocol SelectedMemberTableCellDelegate: AnyObject {
    func removeButtonTapped(cell: SelectedMemberTableCell)
}

class SelectedMemberTableCell: UITableViewCell {
    
    weak var delegate: SelectedMemberTableCellDelegate?
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberStatus: UILabel!
    @IBOutlet weak var memberRemove: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func removeButtonTapped(_ sender: UIButton) {
            delegate?.removeButtonTapped(cell: self)
        }
    
}
