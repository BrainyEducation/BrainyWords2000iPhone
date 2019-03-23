//
//  FitnessDateTimeUtils.swift
//  Fitness
//
//  Created by Thinh Truong on 11/2/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

class RootDateTimeUtils {
    
    static let TimeFormatFull = "%02.f:%02.f:%02.f"
    static let TimeFormatShort = "%02.f:%02.f"

    static func getTimeString(duration: TimeInterval, forceUseHour: Bool = false) -> String{
        
        let time: Double = duration //seconds
        
        let hour = floor(time / 3600)
        
        let min = floor((time - hour * 3600) / 60)
        
        let sec = time - hour * 3600 - min * 60
        
        if hour > 0 || forceUseHour {
            
            return String(format: TimeFormatFull, hour, min, sec)
            
        }
        else {
            return String(format: TimeFormatShort, min, sec)
        }
    }
    
    static func getDateString(duration: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: duration)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMM d__, yyyy"
        let dateString = dateFormatter.string(from: date).replacingOccurrences(of: "__", with: RootDateTimeUtils.daySuffix(from: date))
        return dateString
    }
    
    static func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    static func int64ToDate(_ miliseconds: Int64) -> Date {
        let timeInterval = Double(miliseconds / 1000)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    static func dateToInt64(_ date: Date) -> Int64 {
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    static func getMonday(_ date: Date) -> Date {
        if date.weekday() == 1 {
            return date.dateByAddingDays(-6)
        } else {
            return date.dateByAddingDays(2 - date.weekday())
        }
    }
    
    static func getSunday(_ date: Date) -> Date {
        if date.weekday() == 1 {
            return date.dateByAddingDays(0)
        } else {
            return date.dateByAddingDays(8 - date.weekday())
        }
    }
}
