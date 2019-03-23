//
//  StreetViewItemCell.swift
//  BrainyWords2k
//
//  Created by mac on 9/29/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit
protocol StreetViewItemCellDelegate: class {
    func touchOnScreen(_ touches: Set<UITouch>, with event: UIEvent?, cell:StreetViewItemCell)

}

class StreetViewItemCell: UICollectionViewCell {
    
   weak var delegate : StreetViewItemCellDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.touchOnScreen(touches, with: event, cell:self)
    }
    
    

    

}
