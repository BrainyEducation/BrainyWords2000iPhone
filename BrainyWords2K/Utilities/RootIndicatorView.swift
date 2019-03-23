//
//  FitnessIndicatorView.swift
//  Fitness
//
//  Created by Nguyen Khoi Nguyen on 10/29/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RootIndicatorView: UIView {
    
    private var indicatorView: NVActivityIndicatorView!
    private var label_Message: UILabel!
    
    var message: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(frame: UIScreen.main.bounds)
        addBackground()
        addIndicator()
        addLabelMessage()

    }
    
    init(size: CGFloat){
        super.init(frame: UIScreen.main.bounds)
        addBackground()
        addIndicator(size: size)
        addLabelMessage()
    }
    
    init(frame: CGRect, superView: UIView){
        super.init(frame: frame)
//        initView(frame: frame, superView: superView)
    }
    
    init(superView: UIView){
        super.init(frame: superView.frame)
//        initView(frame: superView.frame, superView: superView)
    }
    
    private func initView(frame: CGRect, superView: UIView){
        self.backgroundColor = UIColor.clear
        let appDel = UIApplication.shared.delegate as! AppDelegate
        self.frame = (appDel.window?.rootViewController?.view.frame)!
        addBackground()
        addIndicator()
        addLabelMessage()
        superView.addSubview(self)
        
    }
    
    private func addBackground(){
        let imageView_Background = UIImageView(frame: frame)
        imageView_Background.backgroundColor = UIColor.black
        imageView_Background.alpha = 0.5
        self.addSubview(imageView_Background)
    }
    
    private func addIndicator(size: CGFloat?=nil){
        var preferedSize: CGFloat!
        
        if let customSize = size{
            preferedSize = customSize
        }else{
            preferedSize = UIScreen.main.bounds.size.width/12

        }
        let indicatorSize = CGSize(width: preferedSize, height: preferedSize)
        let centeOrigin = CGPoint(x: frame.midX-preferedSize/2, y: frame.midY-preferedSize/2)
        indicatorView = NVActivityIndicatorView(frame: CGRect(origin: centeOrigin, size: indicatorSize))
        
        self.addSubview(indicatorView)
    }
    
    private func addLabelMessage(){
        let labelFrame = CGRect(x: indicatorView.frame.origin.x, y: indicatorView.frame.maxY + 16, width: self.frame.width-64, height: 32)
        label_Message = UILabel(frame: labelFrame)
        label_Message.textColor = UIColor.white
        label_Message.font = UIFont.systemFont(ofSize: 17)
        label_Message.isHidden = true
        label_Message.adjustsFontSizeToFitWidth = true
        label_Message.textAlignment = .center
        label_Message.center = CGPoint(x: indicatorView.center.x, y: label_Message.center.y)
        self.addSubview(label_Message)
    }
    
    func show(inController: UIViewController? = nil){
        if message != nil{
            label_Message.text = message!
            label_Message.isHidden = false
        }
        
        if let controller = inController {
            
            controller.view.addSubview(self)
            
        } else {
            //let appDel = UIApplication.shared.delegate as? AppDelegate
            //appDel?.window?.rootViewController?.view.addSubview(self)
            
            UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        }
        
        indicatorView.startAnimating()
        
    }
    
    func dismiss(){
        indicatorView.stopAnimating()
        self.removeFromSuperview()
    }
    
}
