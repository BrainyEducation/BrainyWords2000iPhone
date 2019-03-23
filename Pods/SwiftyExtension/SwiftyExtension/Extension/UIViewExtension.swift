// UIViewExtensions.swift
import Foundation
import UIKit

public extension UIView {

    func setBorder(borderWidth: CGFloat?=nil,
                   borderColor: UIColor?=nil,
                   cornerRadius: CGFloat?=nil){
        
        if let borderWidth = borderWidth{
            self.layer.borderWidth = borderWidth
        }
        
        if let borderColor = borderColor{
            self.layer.borderColor = borderColor.cgColor
        }
        
        if let cornerRadius = cornerRadius{
            //Fix ios 10
            self.layoutIfNeeded()
            self.layer.cornerRadius = cornerRadius
        }
    }

    func setShadow(shadowColor: UIColor=UIColor.black,
                   offset: CGSize=CGSize.zero,
                   opacity: Float = 1,
                   radius: CGFloat = 1){
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
    }
    

    
    /*
     Capture a view as UIImage
     **/
    func captureView() -> UIImage {
        let rect = self.bounds;
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        let context = UIGraphicsGetCurrentContext();
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
       
    }
    
    //
    // MARK: - Frame properties getter
    var x: CGFloat{
        return self.frame.origin.x
    }
    
    var y: CGFloat{
        return self.frame.origin.y
    }
    
    var width:CGFloat{
        return self.frame.size.width
    }
    
    var height:CGFloat{
        return self.frame.size.height
    }
    
}
