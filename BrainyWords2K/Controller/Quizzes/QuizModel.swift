//
//  QuizModel.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/8/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class QuizModel: NSObject {
    
    static let shared = QuizModel()
    
    var coinUpdateBlock: (() -> ())?
    
   // var coinUpdateAnimaiton: (() -> ())?
    
    
    
    func add(type: AnswerRewardType,specialPath:String){
        switch type {
        case .gold:
            //TODO: fix now
            Utility.shared.addScores(key: specialPath, value: 1)
        case .silver:
           
             Utility.shared.addScores(key: specialPath, value: 0.5)
        default: break
        }
    
        //Utility.shared.writeScores(key: specialPath, value: Utility.shared.readScores(key: specialPath)! - 2)
       // Utility.shared.writeScores(key: specialPath, value: 123)
       // print("path:\(Utility.shared.readScores(key: specialPath) ?? 0)")
        // check is reset cagory
        if Utility.shared.readScores(key: specialPath) ?? 0 >= 3125.0 {
            Utility.shared.writeScores(key: specialPath, value: 0)
        }
        //check is total reset
        if Int(getAllCoin()) >= 3125 {
            resetAllCoin()
        }
        coinUpdateBlock?()
    
    }
    
    
    
    func isHaveAnimate(key:String,type:ValueOfCoin = .stack,isGold:Bool=true) -> Bool{
        var score = 0.5
        if isGold {
            score = 1
        }
        let numberCoin = Utility.shared.readScores(key: key)
        if let number = numberCoin {
            let intScore = number+score
            if ifIntScore(score: intScore) {
                if intScore.truncatingRemainder(dividingBy: Double(type.rawValue)) == 0  {
                    return true
                }
            }
            else{
                if Int(intScore) % type.rawValue == 0 && isGold == true {
                    return true
                }
            }
        }
        return false
    }
    
    func isHaveAnimateScreenTotalCoin(isGold:Bool = true,type:ValueOfCoin = .truck) -> Bool {
        var score = 0.5
        if isGold {
            score = 1
        }
        let totalScore = getAllCoin()
        let intScore = totalScore+score
        //if have animation truck and bank
        if ifIntScore(score: intScore) {
            if intScore.truncatingRemainder(dividingBy: Double(type.rawValue)) == 0 {
                return true
            }
        }
        else{
            if Int(intScore) % type.rawValue == 0 && isGold == true{
                return true
            }
           
        }
         return false
    }
    
    func getAllCoin() -> Double{
        var totalCoin : Double = 0
        for item in Utility.shared.listSpecialPath{
            totalCoin += Utility.shared.readScores(key: item) ?? 0
            //print(Utility.shared.readScores(key: item) ?? 0)
        }
      
        return totalCoin
    }
    
    func resetAllCoin() {
        for item in Utility.shared.listSpecialPath {
            Utility.shared.writeScores(key: item, value: 0)
        }
    }
    
    func exchangeCoins(specialPath:String?)->[Int]{
        var numberCoinOfCate = 0
        if let path = specialPath {
            numberCoinOfCate = Int(Utility.shared.readScores(key: path) ?? 0)
        }
        var packCoin = Int(numberCoinOfCate)
        let numberOfBank = Int(packCoin/625)
        packCoin = packCoin - numberOfBank*625
        
        let numberOfTrucks = Int(packCoin/(125))
        packCoin = packCoin - numberOfTrucks*125
        
        let numberOfBags = Int(packCoin/25)
        packCoin = packCoin - numberOfBags*25
        
        let numberOfStacks = Int(packCoin/5)
        packCoin = packCoin - numberOfStacks*5
        let numberOfGCoins = packCoin
        
        return [numberOfGCoins,numberOfStacks,numberOfBags,numberOfTrucks,numberOfBank]
       
    }
    
    func exchangeDetailCoin(specialPath:String?, type:IndexOfCoin) -> Int {
        let listCoin = exchangeCoins(specialPath: specialPath)
        return listCoin[type.rawValue]
    }
    
    func totalNumberTruck() -> Int {
        
        var totalCoins = Int(QuizModel.shared.getAllCoin())
        
        let numberOfBank = Int(totalCoins/625)
        totalCoins = totalCoins - numberOfBank*625
        
        let numberOfTrucks = Int(totalCoins/(125))
        return numberOfTrucks
    }
    
    func ifIntScore(score:Double) -> Bool{
        if floor(score) == score {
            return true
        }
        return false
    }
    
}

enum ValueOfCoin:Int {
    case gold = 0
    case stack = 5
    case bag = 25
    case truck = 125
    case bank = 625
}

enum IndexOfCoin:Int {
    case gold = 0
    case stack = 1
    case bag = 2
    case truck = 3
    case bank = 4
}


