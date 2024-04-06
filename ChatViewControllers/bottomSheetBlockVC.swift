//
//  bottomSheetBlockVC.swift
//  KiteApp
//
//  Created by Admin on 19/03/24.
//

import UIKit

class bottomSheetBlockVC: UIViewController {

    @IBOutlet weak var logoutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutView.layer.cornerRadius = 20
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            dismiss(animated: true, completion: nil)
        }

    @IBAction func blockBtnHIt(_ sender: UIButton) {
    dismiss(animated: true)
    }
    
    @IBAction func cancelBtnHit(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

