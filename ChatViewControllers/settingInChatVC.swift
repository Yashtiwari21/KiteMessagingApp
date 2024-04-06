//
//  settingInChatVC.swift
//  KiteApp
//
//  Created by Admin on 20/03/24.
//

import UIKit

class settingInChatVC: UIViewController {

    @IBOutlet weak var assistantSwitch: UISwitch!
    @IBOutlet weak var securitySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func securitySwitchEnabled(_ sender: UISwitch) {
        if sender.isOn {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "passCodeInChatVC") as! passCodeInChatVC
                   self.navigationController?.pushViewController(vc, animated: true)
               }
    }
    
}
