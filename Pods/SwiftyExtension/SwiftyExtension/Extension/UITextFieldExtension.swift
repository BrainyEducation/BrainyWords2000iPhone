//
//  UIButtonExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 7/17/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
    
    /*
     Set custom color for placeholder
     **/
    func setPlaceHolderText(placeHolder: String, withColor color: UIColor = UIColor.black){
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    
    func setText(text: String="", withColor color: UIColor = UIColor.black, textAlignment: NSTextAlignment = .left, fontSize: CGFloat=UIFont.labelFontSize){
        self.text = text
        self.textColor = color
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}
