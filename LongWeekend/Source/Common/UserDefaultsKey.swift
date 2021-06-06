//
//  UserDefaultsKey.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var fromDate: DefaultsKey<Date> { .init("fromDate", defaultValue: Date().removeTimestamp()) }
    var toDate: DefaultsKey<Date> { .init("toDate", defaultValue: Date(timeInterval: 60 * 60 * 24 * 365, since: Date()).removeTimestamp()) }
    var nationalHolidaySegment: DefaultsKey<NationalHolidaySegment> { .init("nationalHolidaySegment", defaultValue: .undefined) }
    var sortCriteriaSegment: DefaultsKey<SortCriteriaSegment> { .init("sortCriteriaSegment", defaultValue: .numberOfHolidays) }
    var paidDaysCount: DefaultsKey<Int> { .init("paidDaysCount", defaultValue: 1) }
    var minimumNumberOfHolidays: DefaultsKey<Int> { .init("minimumNumberOfHolidays", defaultValue: 3) }
}
