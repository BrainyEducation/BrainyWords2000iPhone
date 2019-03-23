//
//  UIViewExtension.swift
//  Dungnt
//
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    @IBInspectable var roundCornerIgnoreTL : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight , .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreTR : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreBL : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight , .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    @IBInspectable var roundCornerIgnoreBR : CGFloat{
        get{
            return 0
        }
        set(radius){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight , .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.clear
        }
        set (color) {
            self.layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return 0
        }
        set (width) {
            self.layer.borderWidth = width
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return 0
        }
        set (width) {
            self.layer.cornerRadius = width
            self.layer.masksToBounds = true
        }
    }
    @IBInspectable var _radius: CGFloat {
        get {
            return 0
        }
        set (_radius) {
            self.layer.cornerRadius = _radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return self.layer.cornerRadius == min(self.frame.width, self.frame.height) / 2
        }
        set(value) {
            if value == true {
                self.clipsToBounds = true
                self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get { return UIColor(cgColor: self.layer.shadowColor ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor) }
        set (color) { self.layer.shadowColor = color.cgColor }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set (offset) { self.layer.shadowOffset = offset }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(self.layer.shadowOpacity) }
        set (opacity) { self.layer.shadowOpacity = Float(opacity) }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return CGFloat(self.layer.shadowRadius) }
        set (radius) { self.layer.shadowRadius = radius }
    }
    @IBInspectable var Autoradius: Bool {
        get {
            print("WARNING no getter for UIView.corner_radius")
            return false
        }
        set (_radius) {
            if(_radius){
                self.layer.cornerRadius = (self.frame.size.height * 2 * UIScreen.main.bounds.size.width/320.0)/2
                self.layer.masksToBounds = true
            }
        }
    }
    
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
}

// MARK: - Animation Constants

private let BubbleControlMoveAnimationDuration: TimeInterval = 0.3
private let BubbleControlSpringDamping: CGFloat = 0.5
private let BubbleControlSpringVelocity: CGFloat = 0.2


// MARK: - UIView Extension



extension UIView {
    
    func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
  
    // MARK: Frame Extensions
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set (value) {
            self.frame = CGRect (x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set (value) {
            self.frame = CGRect (x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    var w: CGFloat {
        get {
            return self.frame.size.width
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    var h: CGFloat {
        get {
            return self.frame.size.height
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    
    var position: CGPoint {
        get {
            return self.frame.origin
        } set (value) {
            self.frame = CGRect (origin: value, size: self.frame.size)
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set (value) {
            self.frame = CGRect (origin: self.frame.origin, size: size)
        }
    }
    
    
    var left: CGFloat {
        get {
            return self.x
        } set (value) {
            self.x = value
        }
    }
    
    var right: CGFloat {
        get {
            return self.x + self.w
        } set (value) {
            self.x = value - self.w
        }
    }
    
    var top: CGFloat {
        get {
            return self.y
        } set (value) {
            self.y = value
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.y + self.h
        } set (value) {
            self.y = value - self.h
        }
    }
    
    
    
    func leftWithOffset (offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    func rightWithOffset (offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    func topWithOffset (offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    func botttomWithOffset (offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
}


