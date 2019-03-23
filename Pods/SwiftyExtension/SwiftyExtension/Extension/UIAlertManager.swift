//
//  UIAlertManager.swift
//  SwiftyExtension
//
//  Created by Van Anh on 08/01/2017.
//  Copyright © 2017 Nguyen. All rights reserved.
//

import UIKit

class UIAlertManager: NSObject {

    static let sharedInstance = UIAlertManager()
    
    override init() {
        super.init()
    }
    
    /** Show alert with title, message and type of alert
     **/
    func showMessage(title: String?=nil,
                     message: String?=nil,
                     confirmTitle: String = "OK",
                     cancelTitle: String = "Cancel",
                     preferredStyle: UIAlertControllerStyle = .alert,
                     from viewController: UIViewController? = nil,
                     completion: ((Bool) -> ())?=nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        { (action) in completion?(false)}
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        { (action) in completion?(true) }
        alertController.addAction(confirmAction)
        
        (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true) { }
    }
    
    func showInfo(title: String? = nil,
                  message: String?=nil,
                  confirmTitle: String = "OK",
                  preferredStyle: UIAlertControllerStyle = .alert,
                  from viewController: UIViewController? = nil,
                  completion: (() -> ())?=nil){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        { action in completion?() }
        alertController.addAction(confirmAction)
        
        (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true) { }
        
    }
    
    func showConfirm(title: String? = nil,
                     message: String? = nil,
                     confirmTitle: String = "Yes",
                     cancelTitle: String = "No",
                     preferredStyle: UIAlertControllerStyle = .alert,
                     from viewController: UIViewController? = nil,
                     completion: ((Bool) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let noAction = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            completion?(false)
        }
        alertController.addAction(noAction)
        
        let yesAction = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            completion?(true)
        }
        alertController.addAction(yesAction)
        
        (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true)
    }
    
}
