//
//  UIButtonExtension.swift
//  SwiftyExtension
//
//  Created by Khoi Nguyen on 4/23/17.
//  Copyright © 2017 Nguyen. All rights reserved.
//

import UIKit

public extension UIButton {
    func set(backgroundColor: UIColor,
             titleColor: UIColor,
             title: String,
             font: UIFont){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel!.font = font
    }
    
    func set(backgroundColor: UIColor,
             titleColor: UIColor,
             title: String,
             fontSize: CGFloat){
        self.set(backgroundColor: backgroundColor,
                 titleColor: titleColor,
                 title: title,
                 font: UIFont.systemFont(ofSize: fontSize))
    }
}
