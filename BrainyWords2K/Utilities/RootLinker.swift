//
//  AppDelegate.swift
//  CloudMediaPlayer
//
//  Created by Nguyen Khoi Nguyen on 11/8/18.
//  Copyright © 2018 Hamado Apps Inc. All rights reserved.
//

import Foundation
import ViewDeck
import SwiftyExtension

class RootLinker: NSObject  {
    @objc static let sharedInstance = RootLinker()
    var myScheduleTabIndex: Int = -1
    
    override init() {
        
    }
    
    class func getTopViewController() -> UIViewController? {
        let rc = RootLinker.sharedInstance.rootViewController
        if let nc = rc as? UINavigationController {
            return nc.visibleViewController?.presentedViewController ?? nc.visibleViewController
        } else {
            return rc?.presentedViewController ?? rc
        }
    }
    
    /** get viewcontroller from class name */
    class func getViewController(storyboard: RootStoryboard, aClass:AnyClass) -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: String.className(aClass: aClass))
        return viewController
    }
    
    /** get root viewcontroller from class name */
    class func getRootViewController(storyboard:RootStoryboard, aClass: AnyClass) -> UINavigationController {
        let storyboard = UIStoryboard.storyboard(name: storyboard)
        let viewController = storyboard.viewController(aClass: aClass)
        return viewController as! UINavigationController
    }
    
    class func getRootViewController(nameStoryboard:String, idViewController:String) -> UINavigationController {
        let storyboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: idViewController)
        return viewController as! UINavigationController
    }
    
    class var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private var rootViewController: UIViewController? {
        let viewDeck = UIApplication.shared.keyWindow?.rootViewController
        return viewDeck
    }
    
    var rootViewDeckController: RootViewDeckController? {
        return rootViewController as? RootViewDeckController
    }
    
    
    var rootNav: UINavigationController? {
        return self.rootViewDeckController?.centerViewController as? UINavigationController
        
    }
    
    func viewControllerForLink(link : NSURL, forTab tab : Int? = nil) -> RootViewController {
        _ = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : RootViewController = RootViewController()
        return vc
    }
    
    @objc func dismissModal() {
        let viewDeck = UIApplication.shared.keyWindow?.rootViewController as! RootViewDeckController
        let viewController = viewDeck.centerViewController
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
}
