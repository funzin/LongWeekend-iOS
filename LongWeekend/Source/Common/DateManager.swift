//
//  DateManager.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/21.
//

import Foundation
import HolidayJp

struct DateManager {
    static let shared = DateManager()
    private let calendar: Calendar
    private let formatter: DateFormatter

    init(calendar: Calendar = Calendar.current,
         formatter: DateFormatter = Formatter.defaultFormatter) {
        self.calendar = calendar
        self.formatter = formatter
    }
}

extension DateManager {
    enum Formatter {
        static let defaultFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("yMMMdE")
            return formatter
        }()

        static let holidayJpformatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
}

extension DateManager {
    /// make date array from fromDate to toDate
    func makeAllDays(from: Date, to: Date) -> [Date] {
        let components = calendar.dateComponents([.day], from: from, to: to)
        guard let dayCount = components.day,
              dayCount >= 0 else { return [] }

        let allDays = (0 ... dayCount).compactMap {
            calendar.date(byAdding: .day, value: $0, to: from)
        }
        return allDays
    }

    /// extract only Saturdays and Sundays from allDays
    func extractWeekends(from allDays: [Date]) -> [Date] {
        return allDays.filter {
            let component = calendar.component(.weekday, from: $0)
            return component == 1 || component == 7
        }
    }

    /// make nationalHolidays from fromDate to toDate using HolidayJP
    func makeNationalHolidays(from: Date, to: Date) -> [Date] {
        let holidays = HolidayJp.between(from, and: to, calendar: calendar)
        return holidays.compactMap { Formatter.holidayJpformatter.date(from: $0.ymd) }
    }

    /// create two dimension array of holidays
    ///
    /// ```
    /// // e.g.
    /// holidaysArray = [[2018/01/01], [2018/01/06, 2018/01/07, 2018/01/08], [2018/01/13, 2018/01/14]...]
    /// ```
    func createHolidaysArray(holidays: [Date]) -> [[Date]] {
        var holidaysArray = [[Date]]()
        for day in holidays.sorted() {
            let yesterday = calendar.date(byAdding: .day, value: -1, to: day)

            if let lastArray = holidaysArray.last,
               let lastIndex = holidaysArray.indices.last,
               yesterday == lastArray.last {
                holidaysArray[lastIndex].append(day)
            } else {
                holidaysArray.append([day])
            }
        }
        return holidaysArray
    }
}

extension DateManager {
    func date(from dateString: String) -> Date {
        guard let date = formatter.date(from: dateString) else {
            fatalError("should not reach here")
        }
        return date
    }

    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }
}
