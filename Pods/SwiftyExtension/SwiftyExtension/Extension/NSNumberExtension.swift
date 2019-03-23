//
//  NSNumberExtension.swift
//  SwiftyExtension
//
//  Created by Khoi Nguyen on 7/25/18.
//  Copyright © 2018 Nguyen. All rights reserved.
//

import UIKit

struct Number {
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension NSInteger {
    var stringFormatedWithSepator: String {
        let number = NSNumber(integerLiteral: hashValue)
        return Number.formatterWithSepator.string(from: number) ?? ""
    }
}
extension Double{
    
    func stringWithSeparator(minimumFractionDigits: Int=0, maximumFractionDigits: Int=8) -> String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumIntegerDigits = 1
        
        return formatter.string(from: NSNumber.init(value: self)) ?? ""
    }
    
    func toString(maximumFractionDigits: Int=0) -> String {
        return String(format: "%.\(maximumFractionDigits)f", self)
    }
}
