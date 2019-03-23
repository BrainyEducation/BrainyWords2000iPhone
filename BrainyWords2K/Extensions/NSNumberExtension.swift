//
//  NSNumberExtension.swift
//  Fitness
//
//  Created by Duc Nguyen on 11/7/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

struct Number {
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

extension NSInteger {
    var stringFormatedWithSepator: String {
        let number = NSNumber(integerLiteral: hashValue)
        return Number.formatterWithSepator.string(from: number) ?? ""
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formatteNumberdWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Double{
    var currencyString: String{
        get{
            return String(format: "%.2f", self)
        }
    }
    
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: self as NSNumber) ?? ""
    }
    
    func toString(value: String) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        if let n = f.number(from: value) {
            return String(format: "%.2f", n.floatValue)
        }
        return "0.00"
    }
    
    var fileSizeString: String{
        var unit = ""
        var shorten: Double = 0
        
        if self > 1000000000{
            unit = "GB"
            shorten = self/1000000000
        } else if self > 1000000{
            unit = "MB"
            shorten = self/1000000
        } else if self > 1000{
            unit = "KB"
            shorten = self/1000
        } else{
            unit = "B"
            shorten = self
        }
        
        return shorten.stringFormatedWithSepator + " " + unit
    }
    
}

