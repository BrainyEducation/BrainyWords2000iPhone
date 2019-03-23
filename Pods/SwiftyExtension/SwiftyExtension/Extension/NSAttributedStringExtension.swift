//
//  NSAttributedStringExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 10/27/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    // MARK: Return a new NSAttributed title with same attributes 
    func changeText(text: String) -> NSAttributedString {
        let attributes = self.attributes(at: 0, effectiveRange: nil)
        return NSAttributedString(string: text, attributes: attributes)
    }
}

public extension NSMutableAttributedString{
    
    func change(string : String, with color: UIColor){
        self.addAttribute(key: .foregroundColor, value: color, at: string)
    }
    
    func addAttribute(key: NSAttributedStringKey, value: Any, at string: String){
        self.addAttribute(key, value: value, range: self.string.rangeOfAString(string: string))
    }
    
    func addAttribute(spacing: CGFloat, at string: String){
        self.addAttribute(key: .kern, value: spacing, at: string)
    }
    
    func addAttribute(lineSpacing: CGFloat, alignment: NSTextAlignment, at string: String){
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        // *** Apply attribute to string ***
        self.addAttribute(key: .paragraphStyle,
                          value: paragraphStyle,
                          at: string)
    }
    
}
