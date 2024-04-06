//
//  GroupChatVC.swift
//  KiteApp
//
//  Created by Admin on 23/03/24.
//

import UIKit

class GroupChatVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var messageBoxView: UIView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupLastSeen: UILabel!
    @IBOutlet weak var chatBoxView: UIView!
    @IBOutlet weak var chatBoxView1: UIView!
    @IBOutlet weak var chatBoxView2: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    var selectedMembers: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBoxView.layer.cornerRadius = 30
        chatBoxView.layer.cornerRadius = 12
        chatBoxView1.layer.cornerRadius = 12
        chatBoxView2.layer.cornerRadius = 12
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
        if let imageData = ContentModel.shared.groupImage{
                userImage.image = imageData
            } else {
                // Default image if ContentModel.shared.groupImage is nil or image data is corrupted
                userImage.image = UIImage(systemName: "person.fill")
            }
        
        groupName.text = ContentModel.shared.groupName
    }

    @IBAction func menuBtnHit(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Customize font size and font family
        let actionsFont = UIFont(name: "Helvetica Neue", size: 15) ?? UIFont.systemFont(ofSize: 15)
        
        // Add actions
        let viewContactAction = UIAlertAction(title: "View Group Info", style: .default) { (action) in
            let blockVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GroupProfileVC") as! GroupProfileVC
            blockVC.selectedMembers = self.selectedMembers
            self.navigationController?.pushViewController(blockVC, animated: true)
        }
        viewContactAction.setValue(UIColor.black, forKey: "titleTextColor") // Set text color to black
        alertController.addAction(viewContactAction)
        
        let clearChatAction = UIAlertAction(title: "Clear Chat", style: .default) { (action) in
            // Handle Clear Chat action
        }
        clearChatAction.setValue(UIColor.black, forKey: "titleTextColor") // Set text color to black
        alertController.addAction(clearChatAction)
        
        let muteNotificationAction = UIAlertAction(title: "Mute Notification", style: .default) { (action) in
            // Handle Mute Notification action
        }
        muteNotificationAction.setValue(UIColor.black, forKey: "titleTextColor") // Set text color to black
        alertController.addAction(muteNotificationAction)
        
        let blockAction = CustomAlertAction(title: "Block", style: .destructive) { (action) in
            let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "bottomSheetBlockVC") as! bottomSheetBlockVC
            let navigationController_temp = UINavigationController(rootViewController: menuVC)
            navigationController_temp.navigationBar.isHidden = true
            navigationController_temp.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(navigationController_temp, animated: true)
        }
        blockAction.setValue(UIColor.red, forKey: "titleTextColor") // Set text color to black
        blockAction.attributedTitle = NSAttributedString(string: "Block", attributes: [NSAttributedString.Key.font: actionsFont])
        alertController.addAction(blockAction)
        
        // Present the alertController
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        // Prevent dismissing alert when tapping anywhere
        if let presentationController = alertController.popoverPresentationController {
            presentationController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideAlert(_:)))
                tapGestureRecognizer.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapOutsideAlert(_ recognizer: UITapGestureRecognizer) {
           if let presentedViewController = presentedViewController,
               presentedViewController is UIAlertController {
               dismiss(animated: true, completion: nil)
           }
       }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
