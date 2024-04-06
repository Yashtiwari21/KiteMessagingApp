//
//  ChatDashboardVC.swift
//  KiteApp
//
//  Created by Admin on 19/03/24.
//

import UIKit

class ChatDashboardVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var messageBoxView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLastSeen: UILabel!
    @IBOutlet weak var chatBoxView: UIView!
    @IBOutlet weak var chatBoxView1: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    var uImage = UIImage()
    var uName = ""
    var uLastSeen = ""
    var uImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBoxView.layer.cornerRadius = 30
        chatBoxView.layer.cornerRadius = 12
        chatBoxView1.layer.cornerRadius = 12
        userImage.image = uImage
        userName.text = uName
        userLastSeen.text = uLastSeen
        
    }
    
    @IBAction func callBtnPress(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VoiceCallVC") as! VoiceCallVC
        vc.uImage = self.uImage
        vc.uName = self.uName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnHit(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Customize font size and font family
        let actionsFont = UIFont(name: "Helvetica Neue", size: 15) ?? UIFont.systemFont(ofSize: 15)
        
        // Add actions
        let viewContactAction = UIAlertAction(title: "View Contact", style: .default) { (action) in
            let blockVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewContactInChatVC") as! ViewContactInChatVC
            blockVC.uName = self.uName
            blockVC.uImg = self.uImg
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
    
}
class CustomAlertAction: UIAlertAction {
    var attributedTitle: NSAttributedString?
}
