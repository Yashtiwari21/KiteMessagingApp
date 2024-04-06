//
//  NotificationVC.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func allowBtnHit(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "threeTabBar") as! threeTabBar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
