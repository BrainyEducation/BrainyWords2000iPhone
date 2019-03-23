//
//  DisplayItemCell.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/4/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

class DisplayItemCell: UICollectionViewCell {

    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binding(title: String, imageName: String){
        lblTitle.text = title
        DispatchQueue.global(qos: .background).async {
            let image = UIImage(contentsOfFile: imageName)
            DispatchQueue.main.async {
                self.imgView.image = image
            }
        }
        
    }

}
