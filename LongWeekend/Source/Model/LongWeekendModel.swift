//
//  LongWeekendModel.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/14.
//

import Foundation

struct LongWeekendModel: Equatable, Identifiable {
    let id: String = UUID().uuidString
    let paidDays: [Date]
    let firstDate: Date
    let lastDate: Date
    let numberOfHolidays: Int
    let containsNationalHoliday: Bool
}

extension LongWeekendModel {

    func equalWithoutID(_ longWeekend: LongWeekendModel) -> Bool {
        return paidDays == longWeekend.paidDays
            && firstDate == longWeekend.firstDate
            && lastDate == longWeekend.lastDate
            && numberOfHolidays == longWeekend.numberOfHolidays
            && containsNationalHoliday == longWeekend.containsNationalHoliday
    }
}
