//
//  QuizCoinViewController.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 12/2/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class QuizCoinViewController: RootViewController {

    var path: String?
    var totalCoins: Double = 0
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var lbTotalScore: UILabel!
     var completionHandler: (() ->())?
    var isAnimateTotalCoin:Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadScores), name: NSNotification.Name.init("didAddCoin"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBack.isHidden = false
        // Do any additional setup after loading the view.
        
        tableView.initialize(delegate: self)
        tableView.registerCellNib(cellClass: QuizCoinContainCell.self)
        
        
        totalCoins = QuizModel.shared.getAllCoin()
        
        //if this view is call for animation is add one more 1 to display becasue real score is update when totaly complte all animation
        if isAnimateTotalCoin {
            imgBack.isHidden = true
            self.totalCoins = self.totalCoins+1
            autoDissmiss()
        }
        
        lbTotalScore.text = Int(totalCoins).formatteNumberdWithSeparator
            self.tableView.reloadData()
        
       
    }
    
    @IBAction private func reloadScores(){
            totalCoins = QuizModel.shared.getAllCoin()
        lbTotalScore.text = Int(totalCoins).formatteNumberdWithSeparator
            self.tableView.reloadData()
    }


}

extension QuizCoinViewController{
    
    @IBAction func backPressed(){
        self.dismiss(animated: true, completion: nil)
//        self.tableView.reloadData()
    }
    
    func autoDissmiss(){

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.75) {
                UIView.animate(withDuration: 1, animations: {
                    self.tableView.alpha = 0
                    self.scoreView.alpha = 0
                    
            }, completion: { (isDone) in
                self.completionHandler?()
                self.dismiss(animated: false, completion: nil)

            })
            
        }
    }
    
}

// MARK: - UITableViewDataSource
extension QuizCoinViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: QuizCoinContainCell.self) as! QuizCoinContainCell
        
            var myCoin = totalCoins
  
        let numberOfBank = myCoin/(625)
        
        myCoin = myCoin.truncatingRemainder(dividingBy: (625))
        let numberOfTruck = myCoin/125
        
        myCoin = myCoin.truncatingRemainder(dividingBy: 125)
        let numberOfBags = myCoin/25
        
        myCoin = myCoin.truncatingRemainder(dividingBy:25)
        let numberOfStacks = myCoin/5
        
        
        let numberOfGCoins = myCoin.truncatingRemainder(dividingBy: 5)
//        let numberOfSCoins = Int(totalCoins.truncatingRemainder(dividingBy: 1))
        
        switch indexPath.row {
        case 0:
            cell.numberOfItems = numberOfBank
            cell.type = .bank
        case 1:
            cell.numberOfItems = numberOfTruck
            cell.type = .truck
        case 2:
            cell.numberOfItems = numberOfBags
            cell.type = .bag
        case 3:
            cell.numberOfItems = numberOfStacks
            cell.type = .stack
        case 4:
            cell.numberOfItems = numberOfGCoins
            cell.type = .gCoin
        default: break
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension QuizCoinViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
