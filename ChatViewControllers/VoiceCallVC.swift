//
//  VoiceCallVC.swift
//  KiteApp
//
//  Created by Admin on 02/04/24.
//

import UIKit

class VoiceCallVC: UIViewController {

    var uImage = UIImage()
    var uName = ""
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.image = uImage
        userName.text = uName
    }

    @IBAction func backBtnHIt(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
