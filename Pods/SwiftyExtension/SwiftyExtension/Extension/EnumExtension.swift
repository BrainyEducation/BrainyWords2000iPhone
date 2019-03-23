//
//  EnumExtension.swift
//  SwiftyExtension
//
//  Created by Van Anh on 08/01/2017.
//  Copyright © 2017 Nguyen. All rights reserved.
//

import UIKit

import Foundation

// enum which provides a count of its cases
public protocol CaseCountable {
    static func countCases() -> Int
    static var caseCount : Int { get }
}


// provide a default implementation to count the cases for Int enums assuming starting at 0 and contiguous
public extension CaseCountable where Self : RawRepresentable, Self.RawValue == Int {
    // count the number of cases in the enum
    static func countCases() -> Int {
        // starting at zero, verify whether the enum can be instantiated from the Int and increment until it cannot
        var count = 0
        while let _ = Self(rawValue: count) { count += 1 }
        return count
    }
}


// MARK: - Example using
//enum ExampleEnum: Int, CaseCountable {
//    case A = 0
//    case B
//    case C
//    static let caseCount = ExampleEnum.countCases()
//}
