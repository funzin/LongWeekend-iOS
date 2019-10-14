//
//  SettingViewModel.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import Combine
import SwiftUI
import SwiftyUserDefaults

final class SettingViewModel: ObservableObject {

    @Published var fromDate: Date
    @Published var toDate: Date
    @Published var nationalHolidaySegment: NationalHolidaySegment
    @Published var sortCriteriaSegment: SortCriteriaSegment
    @Published var paidDaysCount: Int
    @Published var minimumNumberOfHolidays: Int

    private var userDefaults: UserDefaultsProtocol
    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {

        self.fromDate = userDefaults[.fromDate]
        self.toDate = userDefaults[.toDate]
        self.nationalHolidaySegment = userDefaults[.nationalHolidaySegment]
        self.sortCriteriaSegment = userDefaults[.sortCriteriaSegment]
        self.paidDaysCount = userDefaults[.paidDaysCount]
        self.minimumNumberOfHolidays = userDefaults[.minimumNumberOfHolidays]

        self.userDefaults = userDefaults
    }

    func save() {
        userDefaults[.fromDate] = fromDate.removeTimestamp()
        userDefaults[.toDate] = toDate.removeTimestamp()
        userDefaults[.nationalHolidaySegment] = nationalHolidaySegment
        userDefaults[.sortCriteriaSegment] = sortCriteriaSegment
        userDefaults[.paidDaysCount] = paidDaysCount
        userDefaults[.minimumNumberOfHolidays] = minimumNumberOfHolidays
    }
}
