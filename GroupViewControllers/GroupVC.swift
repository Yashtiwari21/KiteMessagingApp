//
//  GroupVC.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class GroupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createGroupBtnHit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddMemberVC") as? AddMemberVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
