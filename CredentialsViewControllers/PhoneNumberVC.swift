

import UIKit
import CountryPickerView

class PhoneNumberVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNumber: UIView!
    @IBOutlet weak var userMobileNum: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryCode1: UILabel!
    
    var userMobileNumber = ""
    var countryCode = ""
    
    let countryPickerView = CountryPickerView()
    
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
           // Regular expression pattern for a valid phone number
           let phoneRegex = #"^\d{10}$"#
           let predicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
           return predicate.evaluate(with: phoneNumber)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.layer.cornerRadius = 15
        phoneNumber.layer.cornerRadius = 10
        
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        countryCode = countryCode1.text ?? ""
        ContentModel.shared.countryC = countryCode
        
        userMobileNum.delegate = self
        
        errorLabel.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userMobileNum {
               // Calculate the new length of the text field
               let currentText = textField.text ?? ""
               let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
               
               // Allow only numeric characters
               let allowedCharacters = CharacterSet.decimalDigits
               let characterSet = CharacterSet(charactersIn: string)
               let isNumeric = allowedCharacters.isSuperset(of: characterSet)
               
               // Show error label if input is not numeric
               if !isNumeric {
                   errorLabel.text = "Please enter a valid phone number"
                   errorLabel.isHidden = false
               } else {
                   errorLabel.isHidden = true
               }
               
               // Allow only 10 characters
               return newText.count <= 10
           }
        
           return true
        }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userMobileNumber = userMobileNum.text ?? ""
        ContentModel.shared.userMobileNumber = userMobileNumber
    }
    
    
    @IBAction func continueBtnHit(_ sender: UIButton) {
        
        guard let phoneNumber = userMobileNum.text, !phoneNumber.isEmpty else {
            errorLabel.text = "Please enter a phone number"
            errorLabel.isHidden = false
                    return
                }
                
                if !validatePhoneNumber(phoneNumber) {
                    errorLabel.text = "Please enter a valid phone number"
                    errorLabel.isHidden = false
                    return
                }
                errorLabel.isHidden = true
                ContentModel.shared.countryC = countryCode1.text
                ContentModel.shared.userMobileNumber = phoneNumber
                
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController2") as! PhoneVerificationVC
                self.navigationController?.pushViewController(vc, animated: true)
                print(ContentModel.shared.userMobileNumber)
    }
    
    @IBAction func countryBtnTapped(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
}
extension PhoneNumberVC: CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        let countryCode = country.code
        let countryFlag = country.flag
        let phoneCode = country.phoneCode
        
        countryImg.image = countryFlag
        countryCode1.text = phoneCode
        
        dismiss(animated: true, completion: nil)
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
}
