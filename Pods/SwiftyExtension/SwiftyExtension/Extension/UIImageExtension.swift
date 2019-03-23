//
//  UIImageExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 7/14/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import Foundation
import UIKit

/*
extension UIImage {
    
    // Return a gray scale version of UIImage
    func convertToGrayScale() -> UIImage {
        let imageRect:CGRect = CGRectMake(0, 0, self.size.width, self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = self.size.width
        let height = self.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        CGContextDrawImage(context, imageRect, self.CGImage)
        let imageRef = CGBitmapContextCreateImage(context)
        let newImage = UIImage(CGImage: imageRef!)
        
        return newImage
    }
    
    // MARK: Return an image with color
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage
    {
        // https://gist.github.com/alexruperez/90f44545b57c25b977c4
        let drawRect = CGRectMake(0.0, 0.0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()

        CGContextClipToMask(context, drawRect, CGImage)
        color.setFill()
        UIRectFill(drawRect)
        drawInRect(drawRect, blendMode: blendMode, alpha: 1)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    // MARK: Return an image with color, anh Nguyen's version
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = imageWithRenderingMode(.AlwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: Return a cropped version of image
    func cropToBounds(width: CGFloat, height: CGFloat) -> UIImage {
        let contextImage: UIImage = UIImage(CGImage: self.CGImage!)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        

        posX = 0
        posY = ((contextSize.height - contextSize.width) / 4)
        cgwidth = contextSize.width
        cgheight = contextSize.width
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
//        self.drawInRect(rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return newImage;
        
        return image
    }
    
    class var snapShot: UIImage{
        get{
            let layer = UIApplication.sharedApplication().keyWindow!.layer
            let scale = UIScreen.mainScreen().scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            
            layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return screenshot
        }
    }
    
    func scaledToWidth(width: CGFloat) -> UIImage{
        let oldWidth = self.size.width;
        let scaleFactor = width / oldWidth;
        
        let newHeight = self.size.height * scaleFactor;
        let newWidth = oldWidth * scaleFactor;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), false, 0)
        self.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func scaledToHeight(height: CGFloat) -> UIImage{
        if self.size.height == 0{
            return UIImage()
        }
        let oldHeight = self.size.height;
        let scaleFactor = height / oldHeight;
        
        let newWidth = self.size.width * scaleFactor;
        let newHeight = oldHeight * scaleFactor;
        
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), false, 0)

        self.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    //
    // MARK: - Make image fit view
    
    func cropRect() -> CGRect {
        let cgImage = self.CGImage!
        let context = createARGBBitmapContextFromImage(cgImage)
        if context == nil {
            return CGRectZero
        }
        
        let height = CGFloat(CGImageGetHeight(cgImage))
        let width = CGFloat(CGImageGetWidth(cgImage))
        
        let rect = CGRectMake(0, 0, width, height)
        CGContextDrawImage(context, rect, cgImage)
        
        let data = UnsafePointer<CUnsignedChar>(CGBitmapContextGetData(context))
        
        if data == nil {
            return CGRectZero
        }
        
        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0
        
        let heightInt = Int(height)
        let widthInt = Int(width)
        //Filter through data and look for non-transparent pixels.
        for y in (0..<heightInt)  {
            let y = CGFloat(y)
            for x in 0..<widthInt{
                let x = CGFloat(x)
                let pixelIndex = (width * y + x) * 4 /* 4 for A, R, G, B */
                
                if data[Int(pixelIndex)] != 0 { //Alpha value is not zero pixel is not transparent.
                    if (x < lowX) {
                        lowX = x
                    }
                    if (x > highX) {
                        highX = x
                    }
                    if (y < lowY) {
                        lowY = y
                    }
                    if (y > highY) {
                        highY = y
                    }
                }
            }
        }
        
        
        return CGRectMake(lowX, lowY, highX-lowX, highY-lowY)
    }
    
    func createARGBBitmapContextFromImage(inImage: CGImageRef) -> CGContextRef? {
        
        let width = CGImageGetWidth(inImage)
        let height = CGImageGetHeight(inImage)
        
        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if colorSpace == nil {
            return nil
        }
        
        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }
        
        let context = CGBitmapContextCreate (bitmapData,
                                             width,
                                             height,
                                             8,      // bits per component
            bitmapBytesPerRow,
            colorSpace,
            CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        return context
    }
    
    var cropTransparentImage: UIImage{

        let newRect = self.cropRect()
        if let imageRef = CGImageCreateWithImageInRect(self.CGImage!, newRect) {
            return UIImage(CGImage: imageRef)
            // Use this new Image
        }
        
        return self
    }
 
}*/
