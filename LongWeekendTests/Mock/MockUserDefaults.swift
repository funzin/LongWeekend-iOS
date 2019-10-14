//
//  MockUserDefaults.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/26.
//

import Foundation
import SwiftyUserDefaults

@testable import LongWeekend
class MockUserDefautls: UserDefaultsProtocol {
    var dict: [String: Any] = [:]

    subscript(key: DefaultsKey<String>) -> String {
        get {
            return dict[key._key] as? String ?? ""
        }
        set(newValue) {
            dict[key._key] = newValue
        }
    }

    subscript(key: DefaultsKey<Int>) -> Int {
        get {
             return dict[key._key] as? Int ?? 0
        }
        set(newValue) {
            dict[key._key] = newValue
        }
    }

    subscript(key: DefaultsKey<Date>) -> Date {
        get {
            return dict[key._key] as? Date ?? Date()
        }
        set(newValue) {
             dict[key._key] = newValue
        }
    }

    subscript(key: DefaultsKey<NationalHolidaySegment>) -> NationalHolidaySegment {
        get {
            return dict[key._key] as? NationalHolidaySegment ?? .undefined
        }
        set(newValue) {
             dict[key._key] = newValue
        }
    }

    subscript(key: DefaultsKey<SortCriteriaSegment>) -> SortCriteriaSegment {
        get {
            return dict[key._key] as? SortCriteriaSegment ?? .date
        }
        set(newValue) {
             dict[key._key] = newValue
        }
    }
}
