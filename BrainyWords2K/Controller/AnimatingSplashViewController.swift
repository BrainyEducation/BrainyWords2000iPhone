//
//  AnimatingSplashViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 9/29/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class AnimatingSplashViewController: RootViewController {

    override func setDataWhenFirstLoad() {
        let bundleURL = Bundle.main.bundleURL
        let openingSound = bundleURL.appendingPathComponent("assets/xtra/HEADINGS/00brainy_words_2000.mp3")
        RootAudioPlayer.shared.playSound(from: openingSound)
        
        Utility.perform(after: RootAudioPlayer.shared.duration) {
            let rootVC = RootLinker.sharedInstance.rootViewDeckController
            let navVC = RootLinker.getViewController(storyboard: .Auth, aClass: RootAuthNavigation.self) as! RootAuthNavigation
            rootVC?.centerViewController = navVC
            let login = RootLinker.getViewController(storyboard: .Auth, aClass: LoginViewController.self)
            let studentVC = RootLinker.getViewController(storyboard: .Auth, aClass: StudentsViewController.self)
            let vc = RootLinker.getViewController(storyboard: .StreetView, aClass: StreetViewController.self)
            
            if RootConstants.token != nil && RootConstants.student_id != nil{
                navVC.setViewControllers([login, studentVC, vc], animated: false)
                return
            }
            
            if RootConstants.token != nil{
                navVC.setViewControllers([login, studentVC], animated: false)
            }
        }

    }
    
    override func setViewWhenDidLoad() {
        
    }

}
