//
//  Data.swift
//  Sohda
//
//  Created by Khoi Nguyen on 6/18/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import UIKit

extension Data {
    var imageBase64String: String{
        return "data:image/png;base64,"+self.base64EncodedString(options: .lineLength64Characters)
    }
    
    var hex: String {
        var hexString = ""
        for byte in self {
            hexString += String(format: "%02X", byte)
        }
        
        return hexString
    }
    
}
