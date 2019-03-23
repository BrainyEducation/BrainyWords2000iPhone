//
//  QuizCoinView.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/5/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class QuizCoinView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private var imgViewSilverCoin: UIImageView!
    @IBOutlet private var widthOfSliverCoin:NSLayoutConstraint!
    let model = QuizModel.shared
    var specialPath:String? {
        didSet{
            if let path = specialPath {
                numberCoinOfCate = Utility.shared.readScores(key: path) ?? 0
                collectionView.reloadData()
                checkSliverCoin()
            }
        }
    }
    var coinSize: CGFloat = 0
    var numberCoinOfCate:Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
       checkSliverCoin()
        
        model.coinUpdateBlock = {
            if let path = self.specialPath {
                self.numberCoinOfCate = Utility.shared.readScores(key: path) ?? 0
                self.collectionView.reloadData()
            }
            self.checkSliverCoin()
            
        }
    }


}

extension QuizCoinView {
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerCellNib(cellClass: QuizCoinCell.self)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        var screenHeight = UIScreen.height
        if #available(iOS 11.0, *) {
            screenHeight -= UIApplication.shared.keyWindow!.rootViewController!.view.safeAreaInsets.bottom
            screenHeight -= UIApplication.shared.keyWindow!.rootViewController!.view.safeAreaInsets.top
        }
        coinSize = (screenHeight-16*2-8-52-8*5)/5
        
        widthOfSliverCoin.constant = coinSize
        layout.itemSize = CGSize(width: coinSize, height: coinSize)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
   
    
    func totalCoin() -> Int{
        let listCoint = QuizModel.shared.exchangeCoins(specialPath: specialPath)
        var totalCoin : Int = 0
        for number in listCoint {
            totalCoin+=number
        }
        return totalCoin
    }
    
    func checkSliverCoin(){
        if floor(self.numberCoinOfCate) == self.numberCoinOfCate { //so nguyen
            self.imgViewSilverCoin.isHidden = true
        }else{
            self.imgViewSilverCoin.isHidden = false
        }
    }
}

extension QuizCoinView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.totalCoin()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: QuizCoinCell.self, for: indexPath) as! QuizCoinCell
        let exchangeListCoin = QuizModel.shared.exchangeCoins(specialPath: specialPath)

        //let numberOfBank =  exchangeListCoin[ValueOfCoin.bank.hashValue]
        
        let numberOfTrucks = exchangeListCoin[IndexOfCoin.truck.rawValue]
      
        let numberOfBags = exchangeListCoin[IndexOfCoin.bag.rawValue]
 
        let numberOfStacks = exchangeListCoin[IndexOfCoin.stack.rawValue]
        
        let numberOfGCoins = exchangeListCoin[IndexOfCoin.gold.rawValue]
        
       
        if indexPath.row < numberOfGCoins{

            cell.binding(imageName: "img_Coin_Gold")
            return cell
        }

        if indexPath.row - numberOfGCoins < numberOfStacks{
            cell.binding(imageName: "img_Coin_Stack")
            return cell
        }

        if indexPath.row - numberOfGCoins - numberOfStacks < numberOfBags{
            cell.binding(imageName: "img_Coin_Bag")
            return cell
        }
        
        let row = indexPath.row - numberOfGCoins - numberOfStacks - numberOfBags

        if row < numberOfTrucks {
            if row % 2 == 0 {
                 cell.binding(imageName: "img_Green_Truck")
            }else{
                 cell.binding(imageName: "img_Red_Truck")
            }
            return cell
        }

        cell.binding(imageName: "img_Bank")
        
        return cell
    }
}

extension QuizCoinView: UICollectionViewDelegate{
    
}
