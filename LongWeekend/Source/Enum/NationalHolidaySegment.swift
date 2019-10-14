//
//  NationalHolidaySegment.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import SwiftyUserDefaults

enum NationalHolidaySegment: Int, Equatable, DefaultsSerializable, Hashable {
    case undefined
    case containsNationalHoliday
    case notContainNationalHoliday
}
