//
//  CreateGroupVC.swift
//  KiteApp
//
//  Created by Admin on 22/03/24.
//

import UIKit

class CreateGroupVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var groupTitle: UITextField!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var errorLblText: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    
    var selectedMembers: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        editProfile.layer.cornerRadius = editProfile.frame.width/2
        editProfile.clipsToBounds = true
        editProfile.isHidden = true
        
        collectionView1.dataSource = self
        collectionView1.reloadData()
        
        groupTitle.delegate = self
    }
    
    @IBAction func EditBtnHit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createGroupBtnHit(_ sender: UIButton) {
        
        let groupName = groupTitle.text ?? ""
               
               if !validateName(groupName) {
                   errorLblText.isHidden = false
                   errorLblText.text = "Please enter group name"
                   return
               }
        
        ContentModel.shared.groupName = groupTitle.text
        ContentModel.shared.groupImage = profileImage.image
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GroupChatVC") as! GroupChatVC
        vc.selectedMembers = self.selectedMembers
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func validateName(_ name: String) -> Bool {
            return !name.isEmpty
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
               ContentModel.shared.groupImage = profileImage.image
               
               updateProfileUI()
               }
               picker.dismiss(animated: true, completion: nil)
       }
       
       @IBAction func editProfileBtnHit(_ sender: UIButton) {
           addPhotoBtnHit(sender) // Call addPhotoBtnHit to allow editing the profile photo
       }
    
    func updateProfileUI() {
        if let _ = profileImage.image {
            editProfile.isHidden = false
            addPhotoBtn.isHidden = true
        } else {
            editProfile.isHidden = true
        }
    }
}

extension CreateGroupVC: UICollectionViewDataSource,UITextFieldDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GroupUserShowCell
        
        let member = selectedMembers[indexPath.item]
        cell.imageView.image = member.image // Set the image of the cell
        
        return cell
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
           if textField == groupTitle {
               ContentModel.shared.groupName = textField.text
           }
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
               return true
           }
           
           if textField == groupTitle {
               // Validate replacement string (allow only characters)
               let allowedCharacters = CharacterSet.letters
               let characterSet = CharacterSet(charactersIn: string)
               let isCharacter = allowedCharacters.isSuperset(of: characterSet)
               
               // Check if the replacement string is empty or contains only characters
               if !string.isEmpty && !isCharacter {
                   if textField == groupTitle {
                       errorLblText.isHidden = false
                       errorLblText.text = "Invalid input"
                   }
                   return false
               } else {
                   // If input is valid, hide the error label
                   if textField == groupTitle {
                       errorLblText.isHidden = true
                   }
               }
           }
           
           return true
        }
}
