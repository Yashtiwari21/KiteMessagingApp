//
//  passCodeInChatVC.swift
//  KiteApp
//
//  Created by Admin on 20/03/24.
//

import UIKit

class passCodeInChatVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var passDigit1: UITextField!
    @IBOutlet weak var passDigit2: UITextField!
    @IBOutlet weak var passDigit3: UITextField!
    @IBOutlet weak var passDigit4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passDigit1.layer.borderWidth = 1
        passDigit1.layer.borderColor = UIColor.black.cgColor
        passDigit1.layer.cornerRadius = 15
        
        passDigit2.layer.borderWidth = 1
        passDigit2.layer.borderColor = UIColor.black.cgColor
        passDigit2.layer.cornerRadius = 15
        
        passDigit3.layer.borderWidth = 1
        passDigit3.layer.borderColor = UIColor.black.cgColor
        passDigit3.layer.cornerRadius = 15
        
        passDigit4.layer.borderWidth = 1
        passDigit4.layer.borderColor = UIColor.black.cgColor
        passDigit4.layer.cornerRadius = 15
        
        passDigit1.delegate = self
        passDigit2.delegate = self
        passDigit3.delegate = self
        passDigit4.delegate = self
        
        passDigit1.tag = 1
        passDigit2.tag = 2
        passDigit3.tag = 3
        passDigit4.tag = 4
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) && !string.isEmpty {
            return false
        }
        
        if string.isEmpty {
            if let previousTextField = view.viewWithTag(textField.tag - 1) as? UITextField {
                previousTextField.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }
        
        if textField.text?.count == 1 {
            if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.text = string
                nextTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if passDigit1.text?.isEmpty ?? true || passDigit2.text?.isEmpty ?? true || passDigit3.text?.isEmpty ?? true || passDigit4.text?.isEmpty ?? true {
            print("Resending OTP...")
        } else {
          
            let PassCode = "\(passDigit1.text!)\(passDigit2.text!)\(passDigit3.text!)\(passDigit4.text!)"
                       
                       // Store OTP in the model class
                       ContentModel.shared.userPasscode = PassCode
                       print(ContentModel.shared.userPasscode)
            
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "passCodeSetInChatVC") as! passCodeSetInChatVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
