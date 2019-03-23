//
//  AppDelegate.swift
//  StyleManager
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

class RootStyleManager {
    static let sharedInstance = RootStyleManager()
    var isTesting:Bool = false
    
    func setupAppearance() {
        setupNav()
        setupBarButtonItem()
        setupTabbarItem()
        setLightStatusBar()
        setupOrther()
    }
    
    func setupNav() {
        
        UINavigationBar.appearance().barStyle = UIBarStyle.default
        
        UINavigationBar.appearance().backgroundColor = UIColor.white
        // navigation bar color
        // UINavigationBar.appearance().barTintColor = RootColor(hex: "#171933").color
         UINavigationBar.appearance().isTranslucent =  false
         UINavigationBar.appearance().tintColor = UIColor.colorWithHexString(hex: "4A4A4A")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor: UIColor.colorWithHexString(hex: "4A4A4A")
        ]
    
        // UINavigationBar.appearance().shadowImage = UIImage()
        // UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    func setLightStatusBar() {
        UIApplication.shared.statusBarStyle = .default
    }
    
    func setupBarButtonItem() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
    }
    
    func setupTabbarItem() {
       UITabBar.appearance().backgroundColor = UIColor.white
    }
    

    func setupOrther() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftViewMode = .never
    }

}
