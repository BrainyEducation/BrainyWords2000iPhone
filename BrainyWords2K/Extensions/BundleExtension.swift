//
//  BundleExtension.swift
//  BangB2
//
//  Created by ducnguyen on 12/8/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
