//
//  ItemObject.swift
//  BrainyWords2k
//
//  Created by Nguyen Dung on 12/7/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemObject:Mappable {
    required init?(map: Map) {
        
    }
    
    var imageUri : String = ""
    var title : String = ""
    
     func mapping(map: Map) {
        imageUri  <- map["imageUri"]
        title <- map["title"]
    }
    
    
}
