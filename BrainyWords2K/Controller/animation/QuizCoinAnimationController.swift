//
//  QuizCoinAnimationController.swift
//  BrainyWords2k
//
//  Created by mac on 10/12/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

enum TypeAnimation : String{
    case stackCoin
    case bagCoin
    case truck
    case bank
}

class QuizCoinAnimationController: RootViewController {

    @IBOutlet weak var imageViewItemCenter: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var destinationItemPoint = CGPoint.zero
    @IBOutlet private weak var constraintCollectionHeight: NSLayoutConstraint!
    @IBOutlet private weak var widthOfCenterItem:NSLayoutConstraint!
    
    var listImageView : [UIImageView] = []
    var completionHandler: (() ->())?
    var typeAction: TypeAnimation!
    var coinSize: CGFloat = 0

    var path:String=""
    var isTotalCoinAnimation:Bool = false
    
    override func setViewWhenDidLoad() {

        constraintCollectionHeight.constant = (coinSize+8)*5
        widthOfCenterItem.constant =  (UIScreen.main.bounds.height-16*2-8-52-8*5)/5
        setupCollectionView()
        setupItemCenter()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

//        self.collectionView.reloadData()
        
    
    }
    
    func setupCollectionView(){
        collectionView.isHidden = true
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        collectionView.registerCellNib(cellClass: QuizCoinCell.self)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let height = collectionView.height/4-8
        layout.itemSize = CGSize(width: coinSize, height: coinSize)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    

    
}

extension QuizCoinAnimationController {
    
    func playSoundAnimation(){
        let url = Utility.getAudioURL(withName: "correct_answer", from: Utility.assets.quizSound)
        RootAudioPlayer.shared.playSound(from: url)
    }
    
    func setupItemCenter(){
        imageViewItemCenter.frame.size = CGSize.init(width: coinSize, height: coinSize)
        imageViewItemCenter.contentMode = .scaleAspectFit
        imageViewItemCenter.isHidden = true
        imageViewItemCenter.animationZoom(scaleX: 0.1, y: 0.1)
        let image : UIImage!
        switch typeAction! {
        case .stackCoin:
            image = #imageLiteral(resourceName: "img_Coin_Stack")
        case .bagCoin:
            image = #imageLiteral(resourceName: "img_Coin_Bag")
        case .truck:  //if animation tong get total number truck else get number category truck
            if isTotalCoinAnimation {
              
                if QuizModel.shared.totalNumberTruck() % 2 == 0 {
                    image = #imageLiteral(resourceName: "img_Green_Truck")
                }else {
                    image = #imageLiteral(resourceName: "img_Red_Truck")
                }
                
            }else{
                if QuizModel.shared.exchangeDetailCoin(specialPath: path, type: .truck) % 2 == 0 {
                    image = #imageLiteral(resourceName: "img_Green_Truck")
                }else {
                    image = #imageLiteral(resourceName: "img_Red_Truck")
                }
            }
           
            
        case .bank:
            image = #imageLiteral(resourceName: "img_Bank")
        }
        imageViewItemCenter.image = image
    }
    
    func animationMakeRoteCoinClockwise(scale:CGFloat,pointDestionation:CGPoint,timeDuration:TimeInterval = 2, listImageView:[UIImageView]){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(timeDuration)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
       
        for item in listImageView{
            item.transform = CGAffineTransform(scaleX: scale, y: scale)
            item.frame.origin = pointDestionation
        }
       
        UIView.commitAnimations()
    }
    
      func animationNewItemAppearForTotalCoin(timeDuration:TimeInterval = 1.5){
           imageViewItemCenter.isHidden = false
        UIView.animate(withDuration: timeDuration, animations: {
             self.imageViewItemCenter.animationZoom(scaleX: 2, y: 2)
        }) { (isDone) in
            UIView.animate(withDuration: 1, animations: {
                self.imageViewItemCenter.alpha = 0
            }, completion: { (isDone) in
                if self.typeAction == .bank {
                    let vc = RootLinker.getViewController(storyboard: .Inside, aClass: CongratulationController.self) as! CongratulationController
                    vc.completionHandler = {
                        self.completionHandler?()
                        self.view.removeFromSuperview()
                        self.removeFromParentViewController()
                    }
                    self.present(vc, animated: true, completion: nil)
                    return
                }
                
                let vc1 = RootLinker.getViewController(storyboard: .Inside, aClass: QuizCoinViewController.self) as! QuizCoinViewController
                vc1.isAnimateTotalCoin = true
                vc1.completionHandler = {
                    self.completionHandler?()
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                }
                
                self.present(vc1, animated: false, completion: nil)
            })
        }
    }
    
    func animationNewItemAppear(timeDuration:TimeInterval = 1.5){
        imageViewItemCenter.isHidden = false
        UIView.animate(withDuration: timeDuration, animations: {
            self.imageViewItemCenter.animationZoom(scaleX: 2, y: 2)
        }, completion: { (isDone) in
            UIView.animate(withDuration: timeDuration, animations: {
                self.imageViewItemCenter.animationZoom(scaleX: 1, y: 1)
                var newOrigin = CGPoint(x: self.destinationItemPoint.x , y: self.destinationItemPoint.y )
              
                if newOrigin.y < 16 {
                    newOrigin.y = 16
                }
                self.imageViewItemCenter.frame.origin = newOrigin
            }, completion: { (isDone) in
                if self.typeAction == .bank {
                    let vc = RootLinker.getViewController(storyboard: .Inside, aClass: CongratulationController.self) as! CongratulationController
                    vc.completionHandler = {
                        self.completionHandler?()
                        self.view.removeFromSuperview()
                        self.removeFromParentViewController()
                    }
                    self.present(vc, animated: true, completion: nil)
                    return
                }
                
                self.completionHandler?()
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
                
            })
        })
    }
    
 
    
    func animate(){
        self.collectionView.performBatchUpdates(nil, completion: {
            (result) in
            // ready
            

            var animationColumn = 0
            switch self.typeAction! {
            case.stackCoin :
                animationColumn = QuizModel.shared.exchangeDetailCoin(specialPath: self.path, type: .stack)
            case .bagCoin:
                animationColumn = QuizModel.shared.exchangeDetailCoin(specialPath: self.path, type: .bag)
            case .truck:
                animationColumn = QuizModel.shared.exchangeDetailCoin(specialPath: self.path, type: .truck)
            case .bank:
                animationColumn = QuizModel.shared.exchangeDetailCoin(specialPath: self.path, type: .bank)
            }

            if let destinationCell = self.collectionView.cellForItem(at: IndexPath.init(row: animationColumn, section: 0)) as? QuizCoinCell{
                self.destinationItemPoint = destinationCell.imgView.convert(destinationCell.imgView.bounds.origin, to: self.view)

            }
            
            for i in 0..<5{
                let indexPath = IndexPath(row: i, section: 0)
                if let cell = self.collectionView.cellForItem(at: indexPath) as? QuizCoinCell{
                    let rect = cell.imgView.convert(cell.imgView.bounds, to: self.view)
                    let imgView = UIImageView(frame: rect)
                    //list left colum image animation
                    switch self.typeAction! {
                    case .stackCoin:
                        imgView.image = #imageLiteral(resourceName: "img_Coin_Gold")
                    case .bagCoin:
                        imgView.image = #imageLiteral(resourceName: "img_Coin_Stack")
                    case .truck:
                        imgView.image = #imageLiteral(resourceName: "img_Coin_Bag")
                    case .bank:
                        if i % 2 == 0 {
                            imgView.image = #imageLiteral(resourceName: "img_Green_Truck")
                        }else {
                            imgView.image = #imageLiteral(resourceName: "img_Red_Truck")
                        }
                    }
                    self.view.addSubview(imgView)
                    self.listImageView.append(imgView)
                }
            }
            
           
                self.playSoundAnimation()
                self.animationMakeRoteCoinClockwise(scale: 0.1, pointDestionation: self.view.center, listImageView: self.listImageView)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.9) {
                    for item in self.listImageView{
                        item.isHidden = true
                    }
                    
                    if self.isTotalCoinAnimation{
                        self.animationNewItemAppearForTotalCoin()
                    }else{
                      
                        self.animationNewItemAppear()
                    }
                   
                }
            
            
        })
    }
   
}

extension QuizCoinAnimationController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: QuizCoinCell.self, for: indexPath) as! QuizCoinCell

        cell.imgView.contentMode = .scaleAspectFit

        if indexPath.row < 5{
            cell.binding(imageName: "img_Coin_Gold")
            return cell
        }
        
        if indexPath.row < 10{
            cell.binding(imageName: "img_Coin_Stack")
            return cell
        }
        
        if indexPath.row < 15 {
            cell.binding(imageName: "img_Coin_Bag")
            return cell
        }
        
        if indexPath.row % 2 == 0 {
            cell.binding(imageName: "img_Green_Truck")
        }
        else {
            cell.binding(imageName: "img_Red_Truck")
        }
        
        return cell
    }
}


