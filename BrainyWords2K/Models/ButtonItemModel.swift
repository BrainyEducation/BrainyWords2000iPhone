//
//  ButtonItemModel.swift
//  BrainyWords2k
//
//  Created by mac on 9/30/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import Foundation
import ObjectMapper

class ButtonItemModel: Mappable {
    required init?(map: Map) {
        
    }
    
    var id:Int = 0
    var name:String = ""
    var percentEndX: CGFloat = 0
    var percentEndY: CGFloat = 0
    var percentStartX: CGFloat = 0
    var percentStartY: CGFloat = 0
    var tag: String = ""
    var typeAction : Int = 0
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        percentEndX <- map["percentEndX"]
        percentEndY <- map["percentEndY"]
        percentStartX <- map["percentStartX"]
        percentStartY <- map["percentStartY"]
        tag         <- map ["tag"]
        typeAction  <- map ["typeAction"]
    }
}


