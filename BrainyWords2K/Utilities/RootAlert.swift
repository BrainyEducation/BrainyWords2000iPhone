//
//  FitnessMessage.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/3/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit


class RootAlert: NSObject {
    var yesAction : UIAlertAction!
    
    static let sharedInstance = RootAlert()
    
    override init() {
        super.init()
    }
    
    /** Show alert with title, message and type of alert
     **/
    func showMessage(title: String, message: String, okButton: String = "OK", cancelButton: String = "Cancel", preferredStyle: UIAlertControllerStyle = .alert, viewCtrl: UIViewController?, success: ((Bool, String) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { (action) in success?(false, "Cancel")}
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: okButton, style: .default) { (action) in
            success?(true, okButton)
        }
        alertController.addAction(OKAction)
        
        if viewCtrl != nil {
            viewCtrl!.present(alertController, animated: true, completion: nil)
        }
        else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true) { }
        }
    }
    
    func showInfo(message: String, action: String = "OK", preferredStyle: UIAlertControllerStyle = .alert, title: String? = "Mucasi Cloud", fromController: UIViewController? = nil, success: ((Bool, String) -> Void)?){
       
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: preferredStyle)
        
        let OKAction = UIAlertAction(title: action, style: .default) { (a) in
            success?(true, action)
        }
        alertController.addAction(OKAction)
     
        (fromController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoSheetForDisconnect(message: String, action: String = "Disconnect", preferredStyle: UIAlertControllerStyle = .actionSheet, title: String? = "Mucasi Cloud ", fromController: UIViewController? = nil, success: ((Bool, String) -> Void)?){
        
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: preferredStyle)
        
        let OKAction = UIAlertAction(title: action, style: .default) { (a) in
            success?(true, action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil)
        alertController.addAction(OKAction)
        alertController.addAction(cancel)
        (fromController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirm(title: String? = nil, message: String, preferredStyle: UIAlertControllerStyle = .alert, from viewController: UIViewController? = nil, success: ((Bool) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            success?(false)
        }
        alertController.addAction(noAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            success?(true)
        }
        alertController.addAction(yesAction)
        
        (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true)
    }
    
   
}
