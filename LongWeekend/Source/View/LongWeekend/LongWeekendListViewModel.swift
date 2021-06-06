//
//  LongWeekendViewModel.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/21.
//

import Combine
import Foundation
import SwiftUI
import SwiftyUserDefaults

final class LongWeekendListViewModel: ObservableObject {
    typealias SaveDataType = (NationalHolidaySegment, SortCriteriaSegment, Int, Int, Date, Date)

    @Published private(set) var longWeekends: [LongWeekendModel] = []

    private let _loadLongWeekends = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []
    private let userDefaults: DefaultsAdapter<DefaultsKeys>

    init(userDefaults: DefaultsAdapter<DefaultsKeys> = Defaults,
         longWeekendCalcurator: LongWeekendCalcurator = LongWeekendCalcurator.shared) {
        self.userDefaults = userDefaults
        do {
            _loadLongWeekends
                .flatMap { _ -> Just<SaveDataType> in
                    let nationalHolidaySegment = userDefaults.nationalHolidaySegment
                    let sortCriteriaSegment = userDefaults.sortCriteriaSegment
                    let paidDaysCount = userDefaults.paidDaysCount
                    let minimumNumberOfHolidays = userDefaults.minimumNumberOfHolidays
                    let fromDate = userDefaults.fromDate
                    let toDate = userDefaults.toDate
                    return Just<SaveDataType>((nationalHolidaySegment, sortCriteriaSegment, paidDaysCount, minimumNumberOfHolidays, fromDate, toDate))
                }
                .removeDuplicates { prev, current -> Bool in
                    prev == current
                }
                .map { nationalHolidaySegment, sortCriteriaSegment, paidDaysCount, minimumNumberOfHolidays, fromDate, toDate -> [LongWeekendModel] in
                    let longWeekends = longWeekendCalcurator.createLongWeekends(paidDaysCount: paidDaysCount,
                                                                                from: fromDate,
                                                                                to: toDate)
                        .lazy
                        .filter { $0.numberOfHolidays >= minimumNumberOfHolidays }
                        .filter {
                            switch nationalHolidaySegment {
                            case .undefined: return true
                            case .containsNationalHoliday: return $0.containsNationalHoliday
                            case .notContainNationalHoliday: return !$0.containsNationalHoliday
                            }
                        }
                        .sorted {
                            switch sortCriteriaSegment {
                            case .date:
                                return $0.firstDate < $1.firstDate
                            case .numberOfHolidays:
                                if $0.numberOfHolidays == $1.numberOfHolidays {
                                    return $0.firstDate < $1.firstDate
                                }
                                return $0.numberOfHolidays > $1.numberOfHolidays
                            }
                        }
                    return longWeekends
                }
                .assign(to: \.longWeekends, on: self)
                .store(in: &cancellables)
        }
    }

    func loadLongWeekend() {
        _loadLongWeekends.send()
    }
}
