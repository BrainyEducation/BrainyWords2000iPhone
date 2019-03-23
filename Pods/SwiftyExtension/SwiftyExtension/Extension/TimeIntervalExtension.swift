//
//  TimeIntervalExtension.swift
//  SwiftyExtension
//
//  Created by Khoi Nguyen on 7/25/18.
//  Copyright © 2018 Nguyen. All rights reserved.
//

import UIKit

public extension TimeInterval{
    static var currentTimeInterval: TimeInterval{
        return Date().timeIntervalSince1970
    }
    
    static var currentTimeIntervalInMiliseconds: TimeInterval{
        return currentTimeInterval*1000
    }
    
    var toString: String{ return "\(self)" }
}
