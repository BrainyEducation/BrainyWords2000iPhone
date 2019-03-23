//
//  UIImage+Utilities.swift
//  Fitness
//
//  Created by Thinh Truong on 10/25/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    func resizeTo(size: CGFloat) -> UIImage? {
        if self.size.width <= size{
            return self
        }
        
        let newWidth = size
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

extension UIImage {
    static func PDFImageWith(_ url: URL, pageNumber: Int, width: CGFloat) -> UIImage? {
        return PDFImageWith(url, pageNumber: pageNumber, constraints: CGSize(width: width, height: 0))
    }
    
    static func PDFImageWith(_ url: URL, pageNumber: Int, height: CGFloat) -> UIImage? {
        return PDFImageWith(url, pageNumber: pageNumber, constraints: CGSize(width: 0, height: height))
    }
    
    static func PDFImageWith(_ url: URL, pageNumber: Int) -> UIImage? {
        return PDFImageWith(url, pageNumber: pageNumber, constraints: CGSize(width: 0, height: 0))
    }
    
    static func PDFImageWith(_ url: URL, pageNumber: Int, constraints: CGSize) -> UIImage? {
        if let pdf = CGPDFDocument(url as CFURL) {
            if let page = pdf.page(at: pageNumber) {
                let size = page.getBoxRect(.mediaBox).size.forConstraints(constraints)
                let cacheURL = url.PDFCacheURL(pageNumber, size: size)
                
                if let url = cacheURL {
                    if FileManager.default.fileExists(atPath: url.path) {
                        if let image = UIImage(contentsOfFile: url.path) {
                            return UIImage(cgImage: image.cgImage!, scale: UIScreen.main.scale, orientation: .up)
                        }
                    }
                }
                
                UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
                if let ctx = UIGraphicsGetCurrentContext() {
                    ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
                    let rect = page.getBoxRect(.mediaBox)
                    ctx.translateBy(x: -rect.origin.x, y: -rect.origin.y)
                    ctx.scaleBy(x: size.width / rect.size.width, y: size.height / rect.size.height)
                    //                    CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(page, .MediaBox, CGRectMake(0, 0, size.width, size.height), 0, true))
                    ctx.drawPDFPage(page)
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    if let image = image {
                        if let url = cacheURL {
                            if let imageData = UIImagePNGRepresentation(image) {
                                try? imageData.write(to: url, options: [])
                            }
                        }
                        return UIImage(cgImage: image.cgImage!, scale: UIScreen.main.scale, orientation: .up)
                    }
                }
            }
        }
        return nil
    }
    
    static func PDFImageSizeWith(_ url: URL, pageNumber: Int, width: CGFloat) -> CGSize {
        if let pdf = CGPDFDocument(url as CFURL) {
            if let page = pdf.page(at: pageNumber) {
                return page.getBoxRect(.mediaBox).size.forConstraints(CGSize(width: width, height: 0))
            }
        }
        return CGSize.zero
    }
}

extension CGSize {
    func forConstraints(_ constraints: CGSize) -> CGSize {
        if constraints.width == 0 && constraints.height == 0 {
            return self
        }
        let sx = constraints.width / width, sy = constraints.height / height
        let s = sx != 0 && sy != 0 ? min(sx, sy) : max(sx, sy)
        return CGSize(width: ceil(width * s), height: ceil(height * s))
    }
}

extension URL {
    func PDFCacheURL(_ pageNumber: Int, size: CGSize) -> URL? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: self.path)
            
            if let fileSize = attributes[FileAttributeKey.size] as! NSNumber? {
                if let fileDate = attributes[FileAttributeKey.modificationDate] as! Date? {
                    let hashables = self.path + fileSize.stringValue + String(fileDate.timeIntervalSince1970) + String(describing: size)
                    
                    let cacheDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] + "/__PDF_CACHE__"
                    do {
                        try FileManager.default.createDirectory(atPath: cacheDirectory, withIntermediateDirectories: true, attributes:nil)
                        
                    } catch {}
                    
                    return URL(fileURLWithPath: cacheDirectory + "/" + String(format:"%2X", hashables.hash) + ".png")
                }
            }
        } catch {}
        
        return nil
    }
}
