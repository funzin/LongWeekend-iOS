//
//  SortCriteriaSegment.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import SwiftyUserDefaults

enum SortCriteriaSegment: Int, Equatable, DefaultsSerializable, Hashable {
    case date
    case numberOfHolidays
}
