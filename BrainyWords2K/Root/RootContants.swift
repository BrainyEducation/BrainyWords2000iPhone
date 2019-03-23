//
//  SohdaContants.swift
//  Sohda
//
//  Created by Duc Nguyen on 5/17/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import SwiftKeychainWrapper

// The enum of the storyboards in the app
enum RootStoryboard: String {
    case Main = "Main"
    case StreetView = "StreetView"
    case Inside = "Inside"
    case Auth = "Auth"
 }


enum RootNavigationPushAnimation: Int {
    case Default = 0
    case BottomTop = 1
    case TopBottom = 2
}


struct RootConstants {
    
    static var token: String?{
        get{
            return Defaults[.token]
        }
        set(value){
            Defaults[.token] = value
        }
    }
    
    static var teacher_id: String?{
        get{
            return Defaults[.teacher_id]
        }
        set(value){
            Defaults[.teacher_id] = value
        }
    }
    
    static var teacher_id_long: String?{
        get{
            return Defaults[.teacher_id_long]
        }
        set(value){
            Defaults[.teacher_id_long] = value
        }
    }
    
    static var student_id: String?{
        get{
            return Defaults[.student_id]
        }
        set(value){
            Defaults[.student_id] = value
        }
    }
    
}

extension DefaultsKeys {
    static let token = DefaultsKey<String?>("token")
    static let teacher_id = DefaultsKey<String?>("teacher_id")
    static let teacher_id_long = DefaultsKey<String?>("teacher_id_long")
    static let student_id = DefaultsKey<String?>("student_id")
   
}

