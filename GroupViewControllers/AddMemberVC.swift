//
//  AddMemberVC.swift
//  KiteApp
//
//  Created by Admin on 21/03/24.
//

import UIKit

struct Member {
    let name: String
    let image: UIImage
    let status: String
    var isSelected: Bool
}

class AddMemberVC: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var groupTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameGroupBtn: UIButton!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var selectedMembers: [Member] = []
    var selectedIndices: Set<Int> = []
    
    var groupUserImage = ["Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294","Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294"]
    var groupUserName = ["Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera","Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera"]
    var groupUserStatus = ["online","last seen yesterday","last seen yesterday","last seen yesterday","12/16/23","12/16/23","online","4:07 PM","3:26 PM","Yesterday","Yesterday","12/16/23","12/16/23","online"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.layer.cornerRadius = 20
        
        groupTable.register(UINib(nibName: "GroupTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        groupTable.delegate = self
        groupTable.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        nameGroupBtn.isHidden = true
        collectionView.isHidden = true
        collectionViewHeightConstraint.constant = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               groupTable.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let point = gestureRecognizer.location(in: groupTable)
                        if let indexPath = groupTable.indexPathForRow(at: point) {
                            
                            if selectedIndices.contains(indexPath.row) {
                                            selectedIndices.remove(indexPath.row)
                                            // Remove the corresponding member from selectedMembers if it's deselected
                                            if let index = selectedMembers.firstIndex(where: { $0.name == groupUserName[indexPath.row] }) {
                                                selectedMembers.remove(at: index)
                                                collectionView.reloadData() // Reload collectionView to reflect changes
                                            }
                                        } else {
                                            selectedIndices.insert(indexPath.row)
                                            // Add the corresponding member to selectedMembers if it's selected
                                            let member = Member(name: groupUserName[indexPath.row],
                                                                image: UIImage(named: groupUserImage[indexPath.row]) ?? UIImage(),
                                                                status: groupUserStatus[indexPath.row],
                                                                isSelected: true)
                                            if !selectedMembers.contains(where: { $0.name == member.name }) {
                                                selectedMembers.append(member)
                                                collectionView.reloadData() // Reload collectionView to reflect changes
                                            }
                                        }
                                        groupTable.reloadData()
                                        updateCollectionViewVisibility()
                                        nameGroupBtn.isHidden = false
                   
                   if let groupProfileVC = navigationController?.viewControllers.first(where: { $0 is GroupProfileVC }) as? GroupProfileVC {
                                       groupProfileVC.selectedMembers = selectedMembers
                                       groupProfileVC.SelectedGroupTable.reloadData()
                                   }
               }
           }
        }
    
    @IBAction func nameGroupBtnHit(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateGroupVC") as! CreateGroupVC
           vc.selectedMembers = selectedMembers // Pass selected members to CreateGroupVC
           self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension AddMemberVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupUserName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableCell
        cell.personImage.image = UIImage(named: groupUserImage[indexPath.row])
        cell.personName.text = groupUserName[indexPath.row]
        cell.personStatus.text = groupUserStatus[indexPath.row]
        
        cell.selectBox.isHidden = !selectedIndices.contains(indexPath.row)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return selectedMembers.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GroupUserCell
            // Configure your collection view cell with selected member data
            let member = selectedMembers[indexPath.item]
            cell.imageView.image = member.image
            return cell
        }
    
    private func updateCollectionViewVisibility() {
            collectionView.isHidden = selectedMembers.isEmpty
            nameGroupBtn.isHidden = selectedMembers.isEmpty
            collectionViewHeightConstraint.constant = selectedMembers.isEmpty ? 0 : 50
        }
}
