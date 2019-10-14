//
//  UserDefaultsKey.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static var fromDate: DefaultsKey<Date> { .init("fromDate", defaultValue: Date().removeTimestamp()) }
    static var toDate: DefaultsKey<Date> { .init("toDate", defaultValue: Date(timeInterval: 60 * 60 * 24 * 365, since: Date()).removeTimestamp()) }
    static var nationalHolidaySegment: DefaultsKey<NationalHolidaySegment> { .init("nationalHolidaySegment", defaultValue: .undefined) }
    static var sortCriteriaSegment: DefaultsKey<SortCriteriaSegment> { .init("sortCriteriaSegment", defaultValue: .numberOfHolidays) }
    static var paidDaysCount: DefaultsKey<Int> { .init("paidDaysCount", defaultValue: 1) }
    static var minimumNumberOfHolidays: DefaultsKey<Int> { .init("minimumNumberOfHolidays", defaultValue: 3) }
}
