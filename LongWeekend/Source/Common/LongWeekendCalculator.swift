//
//  LongWeekendCalculator.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/14.
//

import Foundation
import HolidayJp

struct LongWeekendCalcurator {
    static let shared = LongWeekendCalcurator()
    private let calendar: Calendar
    private let dateManager: DateManager

    init(calendar: Calendar = Calendar.current,
         dateManager: DateManager = .shared) {
        self.dateManager = dateManager
        self.calendar = calendar
    }
}

extension LongWeekendCalcurator {

    /// create longweekends
    func createLongWeekends(paidDaysCount: Int,
                            from: Date,
                            to: Date) -> [LongWeekendModel] {

        let allDays = dateManager.makeAllDays(from: from, to: to)
        let weekends = dateManager.extractWeekends(from: allDays)
        let nationalHolidays = dateManager.makeNationalHolidays(from: from, to: to)
        guard let allHolidays = NSOrderedSet(array: weekends + nationalHolidays).array as? [Date] else { return [] }
        let weekdays = Set(allDays).subtracting(Set(allHolidays)).sorted()
        let holidaysArray = dateManager.createHolidaysArray(holidays: allHolidays)

        var longWeekends = [LongWeekendModel]()
        for (i, holidays) in holidaysArray.enumerated() {

            // extract weekdays before and after holidays
            let prevWeekdays = weekdays.filter { weekday in
                guard let holidaysFirst = holidays.first else { return false }
                return weekday < holidaysFirst
            }
            .suffix(paidDaysCount)

            let nextWeekdays = weekdays.filter { weekday in
                guard let holidaysLast = holidays.last else { return false }
                return weekday > holidaysLast
            }
            .prefix(paidDaysCount)

            let prevAndNextWeekdays = Array(prevWeekdays + nextWeekdays)
            guard !prevAndNextWeekdays.isEmpty else { continue }

            let lastIndex = prevAndNextWeekdays.endIndex - paidDaysCount < 0 ? 0 : prevAndNextWeekdays.endIndex - paidDaysCount

            for day in prevAndNextWeekdays[0...lastIndex] {

                //　determine the paid days
                let paidDays = Array(prevAndNextWeekdays.filter { day <= $0 }.prefix(paidDaysCount))
                guard let firstPaidDay = paidDays.first,
                    let lastPaidDay = paidDays.last else { continue }

                let firstDate: Date
                if prevWeekdays.contains(firstPaidDay) {
                    // connect if the previous day is holiday
                    if let previousDay = calendar.date(byAdding: .day, value: -1, to: firstPaidDay),
                        allHolidays.contains(previousDay) && i != 0,
                        let prevHolidaysFirst = holidaysArray[i - 1].first {
                        firstDate = prevHolidaysFirst
                    } else {
                        firstDate = firstPaidDay
                    }
                } else {
                    guard let holidayFirst = holidays.first else { fatalError("should not reach here") }
                    firstDate = holidayFirst
                }

                let lastDate: Date
                if nextWeekdays.contains(lastPaidDay) {
                    // connect if the next day is holiday
                    if let nextDay = calendar.date(byAdding: .day, value: 1, to: lastPaidDay),
                        allHolidays.contains(nextDay) && i != holidays.indices.last,
                        let nextHolidaysLast = holidaysArray[i + 1].last {
                        lastDate = nextHolidaysLast
                    } else {
                        lastDate = lastPaidDay
                    }
                } else {
                    guard let holidaysLast = holidays.last else { fatalError("should not reach here") }
                    lastDate = holidaysLast
                }

                guard let _numberOfHolidays = calendar.dateComponents([.day], from: firstDate, to: lastDate).day else { continue }
                let numberOfHolidays = _numberOfHolidays + 1

                // whether include nationalHoliday
                let containsNationalHoliday = !(0..<numberOfHolidays)
                    .compactMap { calendar.date(byAdding: .day, value: $0, to: firstDate) }
                    .filter { nationalHolidays.contains($0) }.isEmpty
                let longweekend = LongWeekendModel(paidDays: paidDays,
                                                   firstDate: firstDate,
                                                   lastDate: lastDate,
                                                   numberOfHolidays: numberOfHolidays,
                                                   containsNationalHoliday: containsNationalHoliday)

                let isEmpty = longWeekends.filter { $0.equalWithoutID(longweekend) }.isEmpty
                if isEmpty {
                    longWeekends.append(longweekend)
                }
            }
        }
        return longWeekends
    }
}
