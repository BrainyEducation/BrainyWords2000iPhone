//
//  TimeIntervalExtension.swift
//  Fitness
//
//  Created by Nguyen Khoi Nguyen on 11/8/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import UIKit

extension TimeInterval{
    
    var toDate: Date{
        get{
            return Date(timeIntervalSinceReferenceDate: self)
        }
    }
    
    var hour: Int{
        get{
            return Int(self)/3600
        }
    }
    
    var minute: Int{
        get{
            return (Int(self) / 60) % 60
        }
    }
    
    var second: Int{
        get{
            return Int(self) % 60
        }
    }
    
    var playTimeString: String{
        
        var humanTimeString = String(format: "%02d:%02d", self.minute, self.second)
        if self.hour > 0{
            humanTimeString = String(format: "%02d:", self.hour)+humanTimeString
        }
        return humanTimeString
    }
    
    
}
