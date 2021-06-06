//
//  DateExtension.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/27.
//

import Foundation

extension Date {
    /// remove timestamp from date
    ///
    /// e.g 2018/01/01 10:00 → 2018/01/01 00:00
    func removeTimestamp() -> Date {
        let calendar = Calendar.current
        guard let date = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self)) else {
            fatalError("should not reach here")
        }
        return date
    }
}
