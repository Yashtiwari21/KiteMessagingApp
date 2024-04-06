//
//  ViewController2.swift
//  KiteApp
//
//  Created by Admin on 16/03/24.
//

import UIKit

class PhoneVerificationVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var otpDigit1: UITextField!
    @IBOutlet weak var otpDigit2: UITextField!
    @IBOutlet weak var otpDigit3: UITextField!
    @IBOutlet weak var otpDigit4: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var userPhoneNum: UILabel!
    
    var timer: Timer?
        var remainingSeconds = 90 // 1.5 minutes
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            otpDigit1.delegate = self
            otpDigit2.delegate = self
            otpDigit3.delegate = self
            otpDigit4.delegate = self
            
            otpDigit1.tag = 1
            otpDigit2.tag = 2
            otpDigit3.tag = 3
            otpDigit4.tag = 4
            
            updateButtonLabel()
            let countryC = ContentModel.shared.countryC
            let userMobileNumber = ContentModel.shared.userMobileNumber
            userPhoneNum.text = countryC! + "-" + userMobileNumber!
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
        
        func updateButtonLabel() {
            if otpDigit1.text?.isEmpty ?? true || otpDigit2.text?.isEmpty ?? true || otpDigit3.text?.isEmpty ?? true || otpDigit4.text?.isEmpty ?? true {
                let attributedTitle = NSAttributedString(string: "Resend in \(remainingSeconds) sec", attributes: [
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: actionButton.titleLabel?.font.pointSize ?? 17.0),
                            NSAttributedString.Key.foregroundColor: UIColor.black
                        ])
                        actionButton.setAttributedTitle(attributedTitle, for: .normal)
                actionButton.isEnabled = false
                actionButton.backgroundColor = UIColor.quaternaryLabel
                actionButton.setTitleColor(UIColor.black, for: .normal)
                actionButton.layer.cornerRadius = 15
                startTimer()
            } else {
                let attributedTitle = NSAttributedString(string: "Continue", attributes: [
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: actionButton.titleLabel?.font.pointSize ?? 17.0),
                            NSAttributedString.Key.foregroundColor: UIColor.white
                        ])
                        actionButton.setAttributedTitle(attributedTitle, for: .normal)
                actionButton.isEnabled = true
                actionButton.setTitleColor(UIColor.white, for: .normal)
                stopTimer()
            }
            startTimer()
        }
        
        func startTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                    self.updateButtonLabel()
                }
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        @IBAction func actionButtonTapped(_ sender: UIButton) {
            if otpDigit1.text?.isEmpty ?? true || otpDigit2.text?.isEmpty ?? true || otpDigit3.text?.isEmpty ?? true || otpDigit4.text?.isEmpty ?? true {
                print("Resending OTP...")
            } else {

                print("Continuing...")
            }
        }
    
    @IBAction func otpVerifyBtnHit(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YourProfileVC") as! YourProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backBtnHit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    }
