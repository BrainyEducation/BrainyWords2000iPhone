//
//  UILabelExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 7/15/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {

    /*
     set label text with custom spacing
     **/
    func setTextWithCustomCharacterSpacing(text: String, spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            NSAttributedStringKey.kern,
            value: CGFloat(spacing),
            range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
    
    func set(text: String = "",
             textColor: UIColor = UIColor.black,
             textAlignment: NSTextAlignment = .left,
             font: UIFont){
        self.set(text: text,
                 textColor: textColor,
                 textAlignment: textAlignment,
                 fontName: font.fontName,
                 fontSize: font.pointSize)
    }
    
    func set(text: String="",
                 textColor: UIColor = UIColor.black,
                 textAlignment: NSTextAlignment = .left,
                 fontName: String="Lato-Regular",
                 fontSize: CGFloat=UIFont.labelFontSize){
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont(name: fontName, size: fontSize)
    }

    
    func add(target: AnyObject, action: Selector){
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
}
