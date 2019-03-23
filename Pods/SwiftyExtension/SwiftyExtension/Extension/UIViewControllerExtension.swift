//
//  UIViewControllerExtension.swift
//  GoldenTime
//
//  Created by Liem Ly Quan on 8/11/16.
//  Copyright © 2016 CAN. All rights reserved.
//

import UIKit


public extension UIViewController {
    
    // MARK: Quickly present create an alert
    func presentDefaultAlert(title: String="", message: String,
                             leftTitle: String="OK",
                             rightTitle: String="Cancel",
                             completion: @escaping (_ tapOnRight: Bool)->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: leftTitle, style: .default){
            action in
            completion(false)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: rightTitle, style: .destructive){
            action in
            completion(true)
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

   
}
