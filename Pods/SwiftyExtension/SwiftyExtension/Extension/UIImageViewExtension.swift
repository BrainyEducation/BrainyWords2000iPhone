//
//  UIImageViewExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 9/16/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import UIKit


public extension UIImageView {
    
    func fillImage(image: UIImage, withColor color: UIColor = UIColor.black, alpha: CGFloat=0.5){
        let renderImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.alpha = alpha
        self.image = renderImage
        self.tintColor = color
    }
 
    
    func add(target: AnyObject, action: Selector){
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
 
}
