//
//  passCodeSetInChatVC.swift
//  KiteApp
//
//  Created by Admin on 20/03/24.
//

import UIKit

class passCodeSetInChatVC: UIViewController,UITextFieldDelegate {
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
            let confirmPassCode = "\(passDigit1.text!)\(passDigit2.text!)\(passDigit3.text!)\(passDigit4.text!)"
                       
                       // Store OTP in the model class
                       ContentModel.shared.userConfirmPasscode = confirmPassCode
                       print(ContentModel.shared.userConfirmPasscode)
            
            if ContentModel.shared.userPasscode == ContentModel.shared.userConfirmPasscode {
                showSuccessMessage()
            }
            else {
                showErrorMessage()
            }
        }
    }
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    private func showSuccessMessage() {
        // Create a custom view for success message
        let successView = UIView(frame: CGRect(x: 0, y: -100, width: view.frame.width, height: 100))
        successView.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.6117647059, blue: 0.2470588235, alpha: 1)
        
        // Add image view for success image
        let imageView = UIImageView(image: UIImage(named: "tick-circle-svgrepo-com (6) 1"))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white // Set image color to white
            imageView.frame = CGRect(x: 60, y: 52, width: 30, height: 30) // Center vertically
            successView.addSubview(imageView)
            
            // Add label for success text
            let label = UILabel(frame: CGRect(x: 100, y: 50, width: successView.frame.width - 120, height: 40))
            label.text = "Passcode Set Successfully"
            label.textColor = .white // Set text color to white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0 // Allow multiple lines if needed
            successView.addSubview(label)
        
        // Add success view to the main view
        view.addSubview(successView)
        
        // Animate the success view
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            successView.frame.origin.y = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 3, options: [.curveEaseInOut], animations: {
                successView.frame.origin.y = -100
            }, completion: { _ in
                successView.removeFromSuperview()
            })
        })
    }
    
    private func showErrorMessage() {
        // Create a custom view for success message
        let successView = UIView(frame: CGRect(x: 0, y: -100, width: view.frame.width, height: 100))
        successView.backgroundColor = #colorLiteral(red: 0.985636172, green: 0.03207439242, blue: 0, alpha: 1)
        
        // Add image view for success image
        let imageView = UIImageView(image: UIImage(systemName: "flag.2.crossed.fill"))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white // Set image color to white
            imageView.frame = CGRect(x: 60, y: 52, width: 30, height: 30) // Center vertically
            successView.addSubview(imageView)
            
            // Add label for success text
            let label = UILabel(frame: CGRect(x: 100, y: 50, width: successView.frame.width - 120, height: 40))
            label.text = "Passcode not Matched"
            label.textColor = .white // Set text color to white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.numberOfLines = 0 // Allow multiple lines if needed
            successView.addSubview(label)
        
        // Add success view to the main view
        view.addSubview(successView)
        
        // Animate the success view
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            successView.frame.origin.y = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 3, options: [.curveEaseInOut], animations: {
                successView.frame.origin.y = -100
            }, completion: { _ in
                successView.removeFromSuperview()
            })
        })
    }
    
}
