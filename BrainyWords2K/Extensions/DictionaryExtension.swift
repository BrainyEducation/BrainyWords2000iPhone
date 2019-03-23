//
//  DictionaryExtension.swift
//  bds_ios
//
//  Created by Dung Nguyen on 12/16/15.
//  Copyright © 2015 Dung Nguyen. All rights reserved.
//

import UIKit

extension Dictionary {
    
        
    func toNumber(keyQuery : Key) -> NSNumber?{
        
        let anyValue = self[keyQuery]
        if(anyValue == nil){
            return nil
        }
        
        if(anyValue is String){
            let intValue: NSNumber? = NumberFormatter().number(from: (anyValue as! String))
            if(intValue != nil){
                return intValue!
            }
        }else if(anyValue is NSNumber){
            return anyValue as? NSNumber
        }
        
        return nil
    }
    func toString(keyQuery : Key) -> String?{
        let anyValue = self[keyQuery]
        if(anyValue == nil){
            return nil
        }
        else if(anyValue is String){
            return anyValue as? String
        }
        else if(anyValue is NSNumber){
            if let value = anyValue as? NSNumber{
                return value.stringValue
            }
        }
        return nil
    }
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
}
