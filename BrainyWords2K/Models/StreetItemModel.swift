//
//  ListButtonItemModel.swift
//  BrainyWords2k
//
//  Created by mac on 9/30/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import Foundation
import ObjectMapper

class StreetItemModel: Mappable {
    required init?(map: Map) {
        
    }
    
    var imageLink : String = ""
    var listInfoButton : [ButtonItemModel] = []
    
    func mapping(map: Map) {
        imageLink <- map["imageLink"]
        listInfoButton <- map["listInfoButton"]
    }
}
