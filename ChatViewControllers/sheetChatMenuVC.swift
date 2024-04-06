//
//  sheetChatMenuVC.swift
//  KiteApp
//
//  Created by Admin on 19/03/24.
//

import UIKit

class sheetChatMenuVC: UIViewController {
    @IBOutlet weak var myAccount: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var myAccountBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAccount.layer.borderColor = UIColor.white.cgColor
        myAccount.layer.borderWidth = 1
        myAccount.layer.cornerRadius = 15
        
        myAccountBtn.layer.borderColor = UIColor.white.cgColor
        myAccountBtn.layer.borderWidth = 1
        myAccountBtn.layer.cornerRadius = 15
        
        settingView.layer.borderColor = UIColor.white.cgColor
        settingView.layer.borderWidth = 1
        settingView.layer.cornerRadius = 15
        
        settingBtn.layer.borderColor = UIColor.white.cgColor
        settingBtn.layer.borderWidth = 1
        settingBtn.layer.cornerRadius = 15
        
        logoutView.layer.borderColor = UIColor.white.cgColor
        logoutView.layer.borderWidth = 1
        logoutView.layer.cornerRadius = 15
        
        logoutBtn.layer.borderColor = UIColor.white.cgColor
        logoutBtn.layer.borderWidth = 1
        logoutBtn.layer.cornerRadius = 15
        
        sheetView.layer.cornerRadius = 20
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func logoutBtnHit(_ sender: UIButton) {
        let logoutVC = self.storyboard?.instantiateViewController(withIdentifier: "logoutInChatVC") as! logoutInChatVC
        let navigationController_temp = UINavigationController(rootViewController: logoutVC)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    

    @IBAction func settingsBtnHit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "settingInChatVC") as? settingInChatVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func myAccountBtnHit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "myAccountVC") as? myAccountVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
