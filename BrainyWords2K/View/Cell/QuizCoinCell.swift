//
//  QuizCoinCell.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/9/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class QuizCoinCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.contentMode = .scaleAspectFit
    }
    
    func binding(imageName: String){
        let image = UIImage(named: imageName)
        self.imgView.image = image
    }

}
