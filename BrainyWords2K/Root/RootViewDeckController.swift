//
//  RootViewDeckController
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//


import Foundation
import ViewDeck

class RootViewDeckController : IIViewDeckController, IIViewDeckControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpControllersIfNeeded()
        self.isPanningEnabled = false
        self.delegate = self
    }
    
    func setUpControllersIfNeeded() {
        // if the user is not logged
        
        // check authenticate. if YEs show at the category screen
        
        let fileManager = FileManager()
        let downloadPath = fileManager.documentPath(name: "DownloadFiles")
        let isExsisted = fileManager.isExsist(at: downloadPath)
        if !isExsisted{
            let _ = fileManager.createFolder(at: downloadPath)
        }
        
        
        self.centerViewController = RootLinker.getViewController(storyboard: .Main, aClass: AnimatingSplashViewController.self)
    }
    
    func viewDeckController(_ viewDeckController: IIViewDeckController!, shouldOpenViewSide viewDeckSide: IIViewDeckSide) -> Bool {
        return true
    }
    
    func viewDeckController(_ viewDeckController: IIViewDeckController!, applyShadow shadowLayer: CALayer!, withBounds rect: CGRect) {
        shadowLayer.masksToBounds = false
        shadowLayer.shadowRadius = 0
        shadowLayer.shadowOpacity = 0.15 // 1.0
        shadowLayer.shadowColor = UIColor.black.cgColor //ActigageColor(hex: "#d9d9d9").color.CGColor
        shadowLayer.shadowOffset = CGSize(width: 7, height: 0)
        shadowLayer.shadowPath = CGPath(rect: rect, transform: nil)
    }
}
