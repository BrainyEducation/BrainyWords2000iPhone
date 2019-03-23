//
//  UIStoryboardExtension.swift
//  GoiGas
//
//  Created by Khoi Nguyen on 4/4/17.
//  Copyright © 2017 Khoi Nguyen. All rights reserved.
//

import UIKit
import SwiftyExtension


extension UIStoryboard{
    
    static func viewController(aClass: AnyClass) -> UIViewController{
        return self.storyboard(name: .StreetView).viewController(aClass: aClass)
    }
    
    static func storyboard(name: RootStoryboard) -> UIStoryboard{
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
    
    func viewController(aClass: AnyClass) -> UIViewController{
        return self.instantiateViewController(withIdentifier: String.className(aClass: aClass))
    }
    
}
