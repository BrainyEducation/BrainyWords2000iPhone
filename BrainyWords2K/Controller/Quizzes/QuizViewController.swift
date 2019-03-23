//
//  QuizViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/5/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class QuizViewController: RootViewController {

    @IBOutlet private weak var coinView: QuizCoinView!
    @IBOutlet private weak var pictureView: QuizPictureView!
    
    var items = [DisplayItemObject]()
    var holdingItems = [DisplayItemObject]()
    var specialPath: String?
    
    override func setDataWhenFirstLoad() {
        pictureView.parentController = self
        pictureView.specialPath = specialPath
        pictureView.items = items
        pictureView.holdingItems = holdingItems
        pictureView.generateQuiz()
        coinView.specialPath = specialPath
    }
    
    override func setViewWhenDidLoad() {
        
    }
    
    
    @IBAction func backPressed(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func repeatPressed(){
        pictureView.repeatAnswer()
    }
}

extension QuizViewController{
    
    func pushToAnimationView(typeAnimation:TypeAnimation,isAnimationTotal:Bool=false, completionHandler: (()->())?){
        let vc = RootLinker.getViewController(storyboard: .Inside, aClass: QuizCoinAnimationController.self) as! QuizCoinAnimationController

        vc.typeAction = typeAnimation
        vc.coinSize = coinView.coinSize
        vc.completionHandler = { completionHandler?() }
        vc.path = specialPath ?? ""
        vc.isTotalCoinAnimation = isAnimationTotal
        vc.view.frame = self.view.frame
        vc.didMove(toParentViewController: self)
   
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.animate()
        
    }
    
//    func pushToTotalCoinAnimationView(typeAnimation:TypeAnimation, completionHandler: (()->())?){
//        let vc = RootLinker.getViewController(storyboard: .Inside, aClass: TotalCoinAnimationController.self) as! TotalCoinAnimationController
//
//        vc.typeAction = typeAnimation
//        vc.completionHandler = { completionHandler?() }
//
//        vc.view.frame = self.view.frame
//        vc.didMove(toParentViewController: self)
//
//        self.view.addSubview(vc.view)
//        self.addChildViewController(vc)
//        vc.animateAction()
//
//    }
    
    func animationAction(key:String,completionHandler: (()->())?){
        if QuizModel.shared.isHaveAnimate(key: key, type: .bank) {
            pushToAnimationView(typeAnimation: .bank, completionHandler: completionHandler)
            return
        }

        if QuizModel.shared.isHaveAnimate(key: key, type: .truck){
            pushToAnimationView(typeAnimation: .truck, completionHandler: completionHandler)
            return
        }

        if QuizModel.shared.isHaveAnimate(key: key, type: .bag) {
            pushToAnimationView(typeAnimation: .bagCoin, completionHandler: completionHandler)
            return
        }

//        if QuizModel.shared.isHaveAnimate(key: key, type: .stack)  {
//            pushToAnimationView(typeAnimation: .stackCoin, completionHandler: completionHandler)
//            return
//        }

        pushToAnimationView(typeAnimation: .stackCoin, completionHandler: completionHandler)
    }
    
    func animationTotalScreenCoinAction(completionHandler: (()->())?){
        if QuizModel.shared.isHaveAnimateScreenTotalCoin(type: .bank) {
            pushToAnimationView(typeAnimation: .bank,isAnimationTotal: true, completionHandler: completionHandler)
            return
        }
    
         pushToAnimationView(typeAnimation: .truck,isAnimationTotal: true, completionHandler: completionHandler)
    }
    
    
    
    @IBAction func bagCoinPressed(){
        let vc = RootLinker.getViewController(storyboard: .Inside, aClass: QuizCoinViewController.self) as! QuizCoinViewController
        vc.path = self.specialPath
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

