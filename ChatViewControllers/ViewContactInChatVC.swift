//
//  BlockInChatVC.swift
//  KiteApp
//
//  Created by Admin on 19/03/24.
//

import UIKit
import MessageUI

class ViewContactInChatVC: UIViewController,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var audioCallView: UIView!
    @IBOutlet weak var videoCallView: UIView!
    @IBOutlet weak var blockBtn: UIButton!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var viewName: UILabel!
    @IBOutlet weak var emailView: UIView!
    
    var uName = ""
    var uImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioCallView.layer.borderWidth = 1
        audioCallView.layer.borderColor = UIColor.lightGray.cgColor
        audioCallView.layer.cornerRadius = 10
        
        videoCallView.layer.borderWidth = 1
        videoCallView.layer.borderColor = UIColor.systemGray4.cgColor
        videoCallView.layer.cornerRadius = 10
        
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.lightGray.cgColor
        emailView.layer.cornerRadius = 10
        
        blockBtn.layer.borderWidth = 0.7
        blockBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        viewName.text = uName
        viewImage.image = UIImage(named: uImg)
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMailComposer))
                emailView.addGestureRecognizer(tapGesture)
        
        let tapGestureAudio = UITapGestureRecognizer(target: self, action: #selector(openDialer))
            audioCallView.addGestureRecognizer(tapGestureAudio)
    }
    
    @IBAction func blockBtnHit(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "bottomSheetBlockVC") as! bottomSheetBlockVC
        let navigationController_temp = UINavigationController(rootViewController: menuVC)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openDialer() {
        if let url = URL(string: "+91 8601973650") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Simulator doesn't support phone calls
                let alert = UIAlertController(title: "Phone Call Not Supported", message: "Your device doesn't support phone calls.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func openMailComposer() {
           if MFMailComposeViewController.canSendMail() {
               let mailComposeViewController = MFMailComposeViewController()
               mailComposeViewController.mailComposeDelegate = self
               mailComposeViewController.setToRecipients(["yashlmp2003@gmail.com"])
               mailComposeViewController.setSubject("Subject")
               mailComposeViewController.setMessageBody("Hii Yash", isHTML: false)
               
               present(mailComposeViewController, animated: true, completion: nil)
           } else {
               let alert = UIAlertController(title: "Email Not Supported", message: "Your device doesn't support Email.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       }

       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
       }
}
