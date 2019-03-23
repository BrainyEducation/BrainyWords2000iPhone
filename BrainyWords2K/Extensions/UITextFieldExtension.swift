//
//  UITextFieldExtension.swift
//  Dungnt
//
//

import UIKit
import Foundation

extension UITextField {
    
    var textString : String {
        return self.text ?? ""
    }
    @IBInspectable var paddingContentLeft: CGFloat {
        get {
            return 0
        }
        set (padding) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = UITextFieldViewMode.always
        }
    }
    
    @IBInspectable var paddingContentRight: CGFloat {
        get {
            return 0
        }
        set (padding) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = UITextFieldViewMode.always
        }
    }
    
    
    @IBInspectable var paddingLeft: CGFloat {
        get {
            return 0
        }
        set (padding) {
            layer.sublayerTransform = CATransform3DMakeTranslation(padding, 0, 0)
        }
    }
    @IBInspectable var paddingRight: CGFloat {
        get {
            return 0
        }
        set (padding) {
            layer.sublayerTransform = CATransform3DMakeTranslation(0,padding, 0)
        }
    }
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return UIColor.clear
        }
        set (color) {
            self.attributedPlaceholder = NSAttributedString(string:(self.placeholder ?? "").toLanguage,
                attributes:[NSAttributedStringKey.foregroundColor:color,NSAttributedStringKey.font:self.font!])
        }
    }
    
    func string() -> String {
        return self.text ?? ""
    }
    @IBInspectable var autoFontScare: Bool {
        get {
            return false
        }
        set (scare) {
            self.font = UIFont(name: self.font!.fontName, size: self.font!.pointSize * (!scare ? 1 : (UIScreen.main.bounds.size.width / 320.0)))
            
        }
    }
    @IBInspectable var autoFontPlaceHoder: String {
        get {
            return self.font!.fontName
        }
        set(autoFont){
            let font = UIFont(name: autoFont, size: self.font!.pointSize)
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                            attributes:[NSAttributedStringKey.font:font!])
        }
    }
    @IBInspectable var leftImage: String {
        get {
            return ""
        }
        set(img_name){
            if let img = UIImage(named:img_name){
                let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.h, height: self.h))
                imgView.image = img
                imgView.contentMode = UIViewContentMode.center
                self.leftView = imgView
                self.leftViewMode = UITextFieldViewMode.always
            }
            
        }
    }
	
	func trim() -> UITextField {
		let trimText = (self.text ?? "").trim()
		self.text = trimText
		return self
	}
}

// update clear button
extension UITextField {
    func modifyClearButton(with image : UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 35, height: 15)
        clearButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}
