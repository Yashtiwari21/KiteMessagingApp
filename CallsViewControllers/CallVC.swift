//
//  CallVC.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class CallVC: UIViewController {
    
    var callUserImage = ["Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294","Frame 3293 (1)","Frame 3293 (2)","Frame 3293 (3)","Frame 3293 (4)","Frame 3293 (5)","Frame 3293","Frame 3294"]
    var callUserName = ["Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera","Almayra Zamzamy","Erlan Sadewa","Midala Huera","Nafisa Gitari","Raki Devon","Salsabila Akira","Midala Huera"]
    var callType = ["Vector (6)","Vector (4)","Vector (4)","Vector (6)","Vector (6)","Vector (6)","Vector (6)","Vector (4)","Vector (4)","Vector (6)","Vector (6)","Vector (4)","Vector (6)","Vector (4)"]
    var callUserLastSeen = ["5 minute ago","Yesterday","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM","5 minute ago","Yesterday","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM","December 10, 8:54 PM"]
    
    
    @IBOutlet weak var CallTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CallTableView.delegate = self
        CallTableView.dataSource = self
        CallTableView.register(UINib(nibName: "ChatTableCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    @IBAction func menuBtnTapped(_ sender: UIButton) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sheetChatMenuVC") as? sheetChatMenuVC{
//            if let sheet = vc.sheetPresentationController{
//                sheet.detents = [.medium()]
//                sheet.prefersGrabberVisible = true
//                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//                sheet.preferredCornerRadius = 20
//            }
//            self.navigationController?.present(vc, animated: true)
//        }
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "sheetChatMenuVC") as! sheetChatMenuVC
        let navigationController_temp = UINavigationController(rootViewController: menuVC)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }

}
extension CallVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CallTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableCell
        cell.chatImage.image = UIImage(named: callUserImage[indexPath.row])
        cell.chatUserName.text = callUserName[indexPath.row]
        cell.chatUserTime.isHidden = true
        cell.callTypeBtn.setImage(UIImage(named: callType[indexPath.row]), for: .normal)
        cell.chatUserDesc.text = callUserLastSeen[indexPath.row]
        return cell
    }
}
