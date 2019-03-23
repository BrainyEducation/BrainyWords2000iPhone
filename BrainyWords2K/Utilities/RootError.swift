//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//
import Foundation

class RootError: CustomStringConvertible {
    
    var code : Int
    var message : String

    init(code: Int, message: String){
        self.code = code
        self.message = message
    }
    
    var description: String {
        return "[ActigageError] code: \(self.code), message: \(self.message)"
    }
}
