//
//  UIImageView+Utilities.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    // Thanks to: http://stackoverflow.com/questions/389342/how-to-get-the-size-of-a-scaled-uiimage-in-uiimageview
    func frameForAspectFitImage(img : UIImage) -> CGRect {
        let imageRatio : CGFloat = img.size.width / img.size.height
        let viewRatio : CGFloat = self.frame.size.width / self.frame.size.height
        
        if (imageRatio < viewRatio) {
            let scale = self.frame.size.height / img.size.height
            let width = scale * img.size.width
            let topLeftX = (self.frame.size.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: self.frame.size.height)
        } else {
            let scale = self.frame.size.width / img.size.width
            let height = scale * img.size.height
            let topLeftY = (self.frame.size.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: self.frame.size.width, height: height)
        }
    }
    
    // This method assumes the imageView is square
    func roundedCornerRadius() -> CGFloat {
        return self.frame.width / 2;
    }
    
    func fillImage(image: UIImage, withColor color: UIColor = UIColor.black, alpha: CGFloat=1){
        let renderImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.alpha = alpha
        self.image = renderImage
        self.tintColor = color
    }
}


extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
