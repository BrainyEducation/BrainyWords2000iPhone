//
//  QuizCoinContainCell.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 12/3/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

enum CoinTypes {
    case bank
    case truck
    case bag
    case stack
    case gCoin
    case sCoin
}

class QuizCoinContainCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var numberOfItems: Double = 0{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var type: CoinTypes = .gCoin
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerCellNib(cellClass: QuizCoinCell.self)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        let coinSize = collectionView.height

        layout.itemSize = CGSize(width: coinSize, height: coinSize)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

}

extension QuizCoinContainCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if type == .gCoin && numberOfItems.truncatingRemainder(dividingBy: 1) > 0{
            numberOfItems += 1
        }
        return Int(numberOfItems)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: QuizCoinCell.self, for: indexPath) as! QuizCoinCell
        
        switch type {
        case .bank: cell.binding(imageName: "img_Bank")
        case .truck:
            if indexPath.row % 2 == 0{
                cell.binding(imageName: "img_Green_Truck")
            }else{
                cell.binding(imageName: "img_Red_Truck")
            }
            
            if type == .truck{
                if let cgImage = cell.imgView.image!.cgImage{
                    let image = UIImage(cgImage: cgImage, scale: 1.0, orientation: .upMirrored)
                    cell.imgView.image = image
                }
                
            }
            
        case .bag: cell.binding(imageName: "img_Coin_Bag")
        case .stack: cell.binding(imageName: "img_Coin_Stack")
        default:
            let numberOfSCoins = numberOfItems.truncatingRemainder(dividingBy: 1)
            cell.binding(imageName: "img_Coin_Gold")
            if indexPath.row == Int(numberOfItems) - 1{
                if numberOfSCoins > 0{
                    cell.binding(imageName: "img_Coin_Silver")
                }
                
            }
        }
        return cell
    }
}

extension QuizCoinContainCell: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = collectionView.height * CGFloat(collectionView.numberOfItems(inSection: 0))
        let totalSpacingWidth = CGFloat(4 * (collectionView.numberOfItems(inSection: 0) - 1))
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        

    }
    
}
