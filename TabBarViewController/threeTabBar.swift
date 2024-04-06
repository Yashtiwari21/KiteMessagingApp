//
//  threeTabBar.swift
//  KiteApp
//
//  Created by Admin on 18/03/24.
//

import UIKit

class threeTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        
        // Define font and attributes for normal state
        let normalFont = UIFont(name: "Helvetica Neue", size: 16)!
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.darkGray
        ]
        
        // Define attributes for selected state with the hexadecimal color #0C8901
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 12/255, green: 137/255, blue: 1/255, alpha: 1.0) // UIColor initialized with RGB values
        ]
        
        // Apply attributes for normal and selected states
        appearance.setTitleTextAttributes(normalAttributes, for: .normal)
        appearance.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
