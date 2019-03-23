//
//  UIScreenExtension.swift
//  GoldenTime
//
//  Created by Nguyen Khoi Nguyen on 2/8/17.
//  Copyright © 2017 CAN. All rights reserved.
//

import Foundation
import UIKit

public enum DeviceType{
    case iPhone4, iPhone5, iPhone6, iPhone6Plus, iPad, Undefine
}

public extension UIScreen{
    class var height: CGFloat{
        return self.main.bounds.size.height
    }
    
    class var width: CGFloat{
        return self.main.bounds.size.width
    }
}

public extension UIDevice{
    
 
    class var isPhone: Bool{
        return UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    class var deviceType: DeviceType {
        switch UIScreen.height {
        case DeviceDimensions.iPhone4.height:
            return .iPhone4
        case DeviceDimensions.iPhone5.height:
            return .iPhone5
        case DeviceDimensions.iPhone6.height:
            return .iPhone6
        case DeviceDimensions.iPhone6Plus.height:
            return .iPhone6Plus
        default:
            return .iPad
        }
    }
}

struct DeviceDimensions{
    static let iPhone4 = CGSize(width: 320, height: 480)
    static let iPhone5 = CGSize(width: 320, height: 568)
    static let iPhone6 = CGSize(width: 375, height: 667)
    static let iPhone6Plus = CGSize(width: 414, height: 736)
    
    static let iPad = CGSize(width: 1024, height: 768)
    static let iPadPro = CGSize.zero
}

