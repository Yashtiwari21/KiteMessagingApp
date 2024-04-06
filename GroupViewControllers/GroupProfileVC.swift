//
//  GroupProfileVC.swift
//  KiteApp
//
//  Created by Admin on 01/04/24.
//

import UIKit

class GroupProfileVC: UIViewController {

    var selectedMembers: [Member] = []
    
    @IBOutlet weak var audioCallView: UIView!
    @IBOutlet weak var videoCallView: UIView!
    @IBOutlet weak var AddMemberView: UIView!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var viewName: UILabel!
    @IBOutlet weak var SelectedGroupTable: UITableView!
    @IBOutlet weak var memberCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioCallView.layer.borderWidth = 1
        audioCallView.layer.borderColor = UIColor.lightGray.cgColor
        audioCallView.layer.cornerRadius = 10
        
        videoCallView.layer.borderWidth = 1
        videoCallView.layer.borderColor = UIColor.systemGray4.cgColor
        videoCallView.layer.cornerRadius = 10
        
        AddMemberView.layer.borderWidth = 1
        AddMemberView.layer.borderColor = UIColor.systemGray4.cgColor
        AddMemberView.layer.cornerRadius = 10
        
        viewName.text = ContentModel.shared.groupName
        viewImage.image = ContentModel.shared.groupImage
        viewImage.layer.cornerRadius = viewImage.frame.width / 2
        
        SelectedGroupTable.delegate = self
        SelectedGroupTable.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Reload the table view when the view appears to reflect any changes in selected members
            SelectedGroupTable.reloadData()
            // Update the member count label
            memberCount.text = "\(selectedMembers.count) Members"
        }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension GroupProfileVC: UITableViewDelegate,UITableViewDataSource,SelectedMemberTableCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectedGroupTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectedMemberTableCell
        cell.memberImage.image = selectedMembers[indexPath.row].image
        cell.memberName.text = selectedMembers[indexPath.row].name
        cell.memberStatus.text = selectedMembers[indexPath.row].status
        cell.delegate = self
        return cell
    }
    
    func removeButtonTapped(cell: SelectedMemberTableCell) {
            // Get the table view instance
            guard let tableView = cell.superview as? UITableView else {
                return
            }
            // Get the index path of the cell
            if let indexPath = tableView.indexPath(for: cell) {
                // Remove the corresponding user from the data source
                selectedMembers.remove(at: indexPath.row)
                // Remove the cell from the table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        memberCount.text = "\(selectedMembers.count) Members"
        }
    
}
