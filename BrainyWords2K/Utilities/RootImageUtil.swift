//
//  ImageUtil.swift
//  NobWorld
//
//  Created by Vo Hoang Phu on 2/12/16.
//  Copyright © 2016 Nob. All rights reserved.
//

import Foundation
import UIKit

class RootImageUtil {
	
	// MARK: Resize and crop
	
	static func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
		let size = image.size
		
		let widthRatio  = targetSize.width  / image.size.width
		let heightRatio = targetSize.height / image.size.height
		
		// Figure out what our orientation is, and use that to form the rectangle
		var newSize: CGSize
		if(widthRatio > heightRatio) {
			newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
		} else {
			newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
		}
		
		// This is the rect that we've calculated out and this is what is actually used below
		let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
		
		// Actually do the resizing to the rect using the ImageContext stuff
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		image.draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage
	}
	
	static func downsizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
		if image.size.width > targetSize.width || image.size.height > targetSize.height {
			return resizeImage(image, targetSize: targetSize)
		} else {
			return image
		}
	}
	
	static func squareImage(_ image: UIImage) -> UIImage? {
		let originalWidth  = image.size.width
		let originalHeight = image.size.height
		
		var edge: CGFloat
		if originalWidth > originalHeight {
			edge = originalHeight
		} else {
			edge = originalWidth
		}
		
		let posX = (originalWidth  - edge) / 2.0
		let posY = (originalHeight - edge) / 2.0
		
		let cropSquare = CGRect(x: posX, y: posY, width: edge, height: edge)
		
		if let imageRef = image.cgImage?.cropping(to: cropSquare) {
			return UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: image.imageOrientation)
		} else {
			return nil
		}
	}
	
	
	static func squareImageTo(_ image: UIImage, size: CGSize) -> UIImage? {
		if let image = squareImage(image) {
			return resizeImage(image, targetSize: size)
		} else {
			return nil
		}
	}
	
	
	static func squareImageDownTo(_ image: UIImage, size: CGSize) -> UIImage? {
		if let image = squareImage(image) {
			return downsizeImage(image, targetSize: size)
		} else {
			return nil
		}
	}
	

	
	// MARK: Load Image
	
	
	static func loadImageFromUrl(_ url: String) -> UIImage? {
		if let imageUrl = URL(string: url) {
			if let imageData = try? Data(contentsOf: imageUrl) {
				return UIImage(data: imageData)
			}
		}
		
		return nil
	}
	
	
	static func loadImageFromUrl(_ url: String, responseHandler: @escaping ((_ image: UIImage?) -> Void)) {
        DispatchQueue.global().async {
            let image = loadImageFromUrl(url)
            
            DispatchQueue.main.async { () -> Void in
                responseHandler(image)
            }
        }
	}
    
    static func getImgeSize(fromFileName fileUrl: String?) -> (width: CGFloat, height: CGFloat)?{
        
        guard let fileUrl = fileUrl else {
            return nil
        }
        
        let fileName = ((fileUrl as NSString).lastPathComponent.components(separatedBy: ".")).first
        
        if let sizeComp = fileName?.components(separatedBy: "_").last {
        
            let size = sizeComp.components(separatedBy: "x")
            
            if size.count == 2, let width = Int(size[0]), let height = Int(size[1]) {
            
                return (CGFloat(width), CGFloat(height))
                
            }
            
        }
        
        return nil
        
    }
	
}
