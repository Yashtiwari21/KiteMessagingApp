//
//  ContentModel.swift
//  KiteApp
//
//  Created by Admin on 20/03/24.
//

import Foundation
import UIKit
class ContentModel{
    static let shared = ContentModel()
        
        var userFirstName: String?
        var userLastName: String?
        var countryC:String?
        var userQuote: String?
        var userOtp: String?
        var userPasscode: String?
    var userConfirmPasscode: String?
        var userMobileNumber: String?
        var userImage: String?
        var groupName: String?
        var groupImage: UIImage?
        private init() {}
}
