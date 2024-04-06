//
//  ChatVC.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class ChatVC: UIViewController {

    var chatUserImage = ["Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294","Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294"]
    var chatUserName = ["Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera","Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera"]
    var chatUserLastSeen = ["4:07 PM","3:26 PM","Yesterday","Yesterday","12/16/23","12/16/23","Yesterday","4:07 PM","3:26 PM","Yesterday","Yesterday","12/16/23","12/16/23","Yesterday"]
    var chatUserDescription = ["We solicit your gracious presence at...","Video call","Tonight’s biggest match","Vice call","Video","We solicit your gracious...","0:42","We solicit your gracious presence at...","Video call","Tonight’s biggest match","Vice call","Video","We solicit your gracious...","0:42"]
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "ChatTableCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @IBAction func menuBtnTapped(_ sender: UIButton) {

        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "sheetChatMenuVC") as! sheetChatMenuVC
        let navigationController_temp = UINavigationController(rootViewController: menuVC)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
}
extension ChatVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableCell
        cell.chatImage.image = UIImage(named: chatUserImage[indexPath.row])
        cell.chatUserName.text = chatUserName[indexPath.row]
        cell.chatUserTime.text = chatUserLastSeen[indexPath.row]
        cell.chatUserDesc.text = chatUserDescription[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatDashboardVC") as! ChatDashboardVC
        vc.uImage = UIImage(named: chatUserImage[indexPath.row])!
        vc.uName = chatUserName[indexPath.row]
        vc.uLastSeen = "last seen at \(chatUserLastSeen[indexPath.row])"
        vc.uImg = chatUserImage[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
