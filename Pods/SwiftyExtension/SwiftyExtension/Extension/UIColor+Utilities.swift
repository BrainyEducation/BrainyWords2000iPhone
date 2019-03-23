//
//  UIColor+Utilities.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public class func colorWithHexString(hex : String) -> UIColor {
        
        return UIColor(red: redComponentFromHexString(hex: hex),
            green: greenComponentFromHexString(hex: hex),
            blue: blueComponentFromHexString(hex: hex),
            alpha: alphaComponentFromHexString(hex: hex))
    }
    
    public class func hexStringFromColor(color : UIColor) -> String? {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let s = NSString(format: "#%02lX%02lX%02lX%02lX",
                lroundf(Float(red) * 255),
                lroundf(Float(green) * 255),
                lroundf(Float(blue) * 255),
                lroundf(Float(alpha) * 255))
            return s as String
        }
        return nil
    }

    private class func hexIntFromHexString(hex : String) -> UInt32 {
        var hexString = (hex as NSString).replacingOccurrences(of: "#", with: "")
        if (hexString.count <= 6) {
            hexString.append("ff")
        }

        let scanner = Scanner(string: hexString)
        var hexInt : UInt32 = 0
        
        if (scanner.scanHexInt32(&hexInt)){
            return hexInt
        }
        return 0xFFFFFFFF
    }
    
    class func redComponentFromHexString(hex : String) -> CGFloat {
        let hexInt = UIColor.hexIntFromHexString(hex: hex)
        return CGFloat(((hexInt & 0xFF000000) >> 24))/255.0
    }

    class func greenComponentFromHexString(hex : String) -> CGFloat {
        let hexInt = UIColor.hexIntFromHexString(hex: hex)
        return CGFloat(((hexInt & 0x00FF0000) >> 16))/255.0
    }

    class func blueComponentFromHexString(hex : String) -> CGFloat {
        let hexInt = UIColor.hexIntFromHexString(hex: hex)
        return CGFloat(((hexInt & 0x0000FF00) >> 8))/255.0
    }

    class func alphaComponentFromHexString(hex : String) -> CGFloat {
        let hexInt = UIColor.hexIntFromHexString(hex: hex)
        return CGFloat(((hexInt & 0x000000FF) >> 0))/255.0
    }

    
}

// MARK: - Define color



