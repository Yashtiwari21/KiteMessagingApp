//
//  YourProfileVC.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class YourProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var firstNameTxtF: UITextField!
    @IBOutlet weak var lastNameTxtF: UITextField!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var errorLbl1: UILabel!
    @IBOutlet weak var errorLbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        editProfile.layer.cornerRadius = editProfile.frame.width/2
        editProfile.clipsToBounds = true
        editProfile.isHidden = true
        
        firstNameTxtF.delegate = self
        lastNameTxtF.delegate = self
        
        errorLbl1.isHidden = true
        errorLbl2.isHidden = true
                
                // Load existing data into UI
                if let firstName = ContentModel.shared.userFirstName {
                    firstNameTxtF.text = firstName
                }
                if let lastName = ContentModel.shared.userLastName {
                    lastNameTxtF.text = lastName
                }
            }

    @IBAction func continueBtnHit(_ sender: UIButton) {
        let firstName = firstNameTxtF.text ?? ""
               let lastName = lastNameTxtF.text ?? ""
               
               if !validateName(firstName) {
                   errorLbl1.isHidden = false
                   errorLbl1.text = "Please enter a valid first name with at least 2 characters"
                   return
               }
               
               if !validateName(lastName) {
                   errorLbl2.isHidden = false
                   errorLbl2.text = "Please enter a valid last name with at least 2 characters"
                   return
               }
        
        ContentModel.shared.userFirstName = firstName
        ContentModel.shared.userLastName = lastName
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
           if textField == firstNameTxtF {
               ContentModel.shared.userFirstName = textField.text
           } else if textField == lastNameTxtF {
               ContentModel.shared.userLastName = textField.text
           }
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
               return true
           }
           
           if textField == firstNameTxtF || textField == lastNameTxtF {
               
               let currentText = textField.text ?? ""
               let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
               // Validate replacement string (allow only characters)
               let allowedCharacters = CharacterSet.letters
               let characterSet = CharacterSet(charactersIn: string)
               let isCharacter = allowedCharacters.isSuperset(of: characterSet)
               
               // Check if the replacement string is empty or contains only characters
               if !string.isEmpty && !isCharacter {
                   if textField == firstNameTxtF {
                       errorLbl1.isHidden = false
                       errorLbl1.text = "Invalid input"
                   } else {
                       errorLbl2.isHidden = false
                       errorLbl2.text = "Invalid input"
                   }
                   return false
               } else {
                   // If input is valid, hide the error label
                   if textField == firstNameTxtF {
                       errorLbl1.isHidden = true
                   } else {
                       errorLbl2.isHidden = true
                   }
               }
               return newText.count <= 20
           }
        
           return true
        }
    
    func validateName(_ name: String) -> Bool {
        return !name.isEmpty && name.count >= 2
        }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPhotoBtnHit(_ sender: UIButton) {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action:UIAlertAction) in
               if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   imagePicker.sourceType = .camera
                   self.present(imagePicker, animated: true, completion: nil)
               } else {
                   print("Camera not available")
               }
           }))
           actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (action:UIAlertAction) in
               imagePicker.sourceType = .photoLibrary
               self.present(imagePicker, animated: true, completion: nil)
           }))
           actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           
           self.present(actionSheet, animated: true, completion: nil)
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[.originalImage] as? UIImage {
                   profileImage.image = image
                   if let imageData = image.jpegData(compressionQuality: 1.0) {
                       ContentModel.shared.userImage = imageData.base64EncodedString()
                   }
                   updateProfileUI() // Update UI after setting the profile photo
               }
               picker.dismiss(animated: true, completion: nil)
       }
       
       @IBAction func editProfileBtnHit(_ sender: UIButton) {
           addPhotoBtnHit(sender) // Call addPhotoBtnHit to allow editing the profile photo
       }
       
       func updateProfileUI() {
           if let _ = profileImage.image {
               // Profile photo is set
               profileLabel.text = "Edit Profile"
               editProfile.isHidden = false
               addPhotoBtn.isHidden = true
           } else {
               // Profile photo is not set
               profileLabel.text = "Set Profile Photo"
               editProfile.isHidden = true
           }
       }
   }
