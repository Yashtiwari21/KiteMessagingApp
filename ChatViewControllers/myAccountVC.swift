//
//  myAccountVC.swift
//  KiteApp
//
//  Created by Admin on 19/03/24.
//

import UIKit

class myAccountVC: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtQuote: UITextField!
    @IBOutlet weak var mobileNumLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editProfile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.isEnabled = false
        txtQuote.isEnabled = false
        
        txtName.delegate = self
        txtQuote.delegate = self
        
        editProfile.layer.cornerRadius = editProfile.frame.width / 2
        
        txtName.text = ContentModel.shared.userFirstName! + " " + ContentModel.shared.userLastName!
        mobileNumLbl.text = ContentModel.shared.countryC! + "-" + ContentModel.shared.userMobileNumber!
        txtQuote.text = ContentModel.shared.userQuote
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
        if let imageString = ContentModel.shared.userImage,
                   let imageData = Data(base64Encoded: imageString),
                   let image = UIImage(data: imageData) {
                    userImage.image = image
                }
    }

    @IBAction func txtNameEdit(_ sender: UIButton) {
        txtName.isEnabled = true
        txtName.becomeFirstResponder()
    }
    
    @IBAction func txtQuoteEdit(_ sender: UIButton) {
        txtQuote.isEnabled = true
        txtQuote.becomeFirstResponder()
    }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            textField.isEnabled = false
            return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtName {
            let fullName = textField.text ?? ""
            let components = fullName.components(separatedBy: " ")
            if components.count >= 2 {
                ContentModel.shared.userFirstName = components[0]
                ContentModel.shared.userLastName = components.dropFirst().joined(separator: " ")
            }
        } else if textField == txtQuote {
            ContentModel.shared.userQuote = textField.text
        }
    }

    @IBAction func editBtnHit(_ sender: UIButton) {
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
                   userImage.image = image
                   if let imageData = image.jpegData(compressionQuality: 1.0) {
                       ContentModel.shared.userImage = imageData.base64EncodedString()
                   }
               }
               picker.dismiss(animated: true, completion: nil)
       }
}
