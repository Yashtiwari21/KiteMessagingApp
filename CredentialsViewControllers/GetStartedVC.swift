//
//  ViewController.swift
//  KiteApp
//
//  Created by Admin on 16/03/24.
//

import UIKit

class GetStartedVC: UIViewController {
    @IBOutlet weak var getStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.cornerRadius = 15
    }

    @IBAction func getStartedHit(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController1") as! PhoneNumberVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

