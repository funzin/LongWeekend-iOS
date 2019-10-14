//
//  UserDefaultsProtocol.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/26.
//

import Foundation
import SwiftyUserDefaults

protocol UserDefaultsProtocol {
    subscript(key: DefaultsKey<String>) -> String { get set }
    subscript(key: DefaultsKey<Int>) -> Int { get set }
    subscript(key: DefaultsKey<Date>) -> Date { get set }
    subscript(key: DefaultsKey<NationalHolidaySegment>) -> NationalHolidaySegment { get set }
    subscript(key: DefaultsKey<SortCriteriaSegment>) -> SortCriteriaSegment { get set }
}

extension UserDefaults: UserDefaultsProtocol {}
