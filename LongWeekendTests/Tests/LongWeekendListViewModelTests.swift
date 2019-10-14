//
//  LongWeekendListViewModelTests.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/27.
//

import XCTest

@testable import LongWeekend
class LongWeekendListViewModelTests: XCTestCase {

    var viewModel: LongWeekendListViewModel!
    var mockUserDefaults: MockUserDefautls!
    var dateManager: DateManager!

    override func setUp() {
        self.mockUserDefaults = MockUserDefautls()
        let calendar = Calendar(identifier: .gregorian)
        self.dateManager = DateManager(calendar: calendar, formatter: DateManager.Formatter.holidayJpformatter)
        let longWeekendCalcurator = LongWeekendCalcurator(calendar: calendar, dateManager: dateManager)
        self.viewModel = LongWeekendListViewModel(userDefaults: mockUserDefaults,
                                                  longWeekendCalcurator: longWeekendCalcurator)

    }

    override func tearDown() {
    }

    func test_loadLongWeekend() {
        mockUserDefaults[.fromDate] = dateManager.date(from: "2018-05-02")
        mockUserDefaults[.toDate] = dateManager.date(from: "2018-05-04")
        mockUserDefaults[.nationalHolidaySegment] = .undefined
        mockUserDefaults[.sortCriteriaSegment] = .date
        mockUserDefaults[.paidDaysCount] = 3
        mockUserDefaults[.minimumNumberOfHolidays] = 3
        viewModel.loadLongWeekend()
        XCTAssertFalse(viewModel.longWeekends.isEmpty)
    }

    func test_loadLongWeekend_minimumNumberOfHolidays() {

        struct Input {
            let minimumNumberOfHolidays: Int
            let nationalHolidaySegment: NationalHolidaySegment
        }

        struct Output {
            let isEmpty: Bool
        }

        let testCases: [TestCase<Input, Output>] = [
            .init(input: .init(minimumNumberOfHolidays: 3,
                               nationalHolidaySegment: .undefined),
                  output: .init(isEmpty: false),
                  desc: "when minimumNumberOfHolidays is equal to longWeekend.numberOfHolidays"),
            .init(input: .init(minimumNumberOfHolidays: 4,
                               nationalHolidaySegment: .undefined),
                  output: .init(isEmpty: true),
                  desc: "when minimumNumberOfHolidays is more than longWeekend.numberOfHolidays"),
            .init(input: .init(minimumNumberOfHolidays: 3,
                                nationalHolidaySegment: .containsNationalHoliday),
                   output: .init(isEmpty: false),
                   desc: "when contains nationalHoliday"),
             .init(input: .init(minimumNumberOfHolidays: 3,
                                nationalHolidaySegment: .notContainNationalHoliday),
                   output: .init(isEmpty: true),
                   desc: "when not contain nationalHolida")
        ]

        for testCase in testCases {
            setUp()
            mockUserDefaults[.fromDate] = dateManager.date(from: "2018-05-02")
            mockUserDefaults[.toDate] = dateManager.date(from: "2018-05-04")
            mockUserDefaults[.nationalHolidaySegment] = testCase.input.nationalHolidaySegment
            mockUserDefaults[.sortCriteriaSegment] = .date
            mockUserDefaults[.paidDaysCount] = 1
            mockUserDefaults[.minimumNumberOfHolidays] = testCase.input.minimumNumberOfHolidays

            viewModel.loadLongWeekend()

            XCTAssertEqual(testCase.output.isEmpty, viewModel.longWeekends.isEmpty)
        }
    }

    func test_loadLongWeekend_sortCriteriaSegment() {
        struct Input {
            let from: String
            let to: String
            let sortCriteriaSegment: SortCriteriaSegment
        }

        struct Output {
            let longWeekends: [LongWeekendModel]
        }

        let testCases: [TestCase<Input, Output>] = [
            .init(input: .init(from: "2018-04-29",
                               to: "2018-05-05",
                               sortCriteriaSegment: .date),
                  output: .init(longWeekends: [LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-01")],
                                                                firstDate: dateManager.date(from: "2018-04-29"),
                                                                lastDate: dateManager.date(from: "2018-05-01"),
                                                                numberOfHolidays: 3,
                                                                containsNationalHoliday: true),
                                               LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-02")],
                                                                firstDate: dateManager.date(from: "2018-05-02"),
                                                                lastDate: dateManager.date(from: "2018-05-05"),
                                                                numberOfHolidays: 4,
                                                                containsNationalHoliday: true)
                  ]),
                  desc: "when sortCriteriaSegment is .date"),
            .init(input: .init(from: "2018-04-29",
                               to: "2018-05-05",
                               sortCriteriaSegment: .numberOfHolidays),
                  output: .init(longWeekends: [LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-02")],
                                                                firstDate: dateManager.date(from: "2018-05-02"),
                                                                lastDate: dateManager.date(from: "2018-05-05"),
                                                                numberOfHolidays: 4,
                                                                containsNationalHoliday: true),
                                               LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-01")],
                                                                firstDate: dateManager.date(from: "2018-04-29"),
                                                                lastDate: dateManager.date(from: "2018-05-01"),
                                                                numberOfHolidays: 3,
                                                                containsNationalHoliday: true)
                  ]),
                  desc: "when sortCriteriaSegment is numberOfHolidays"),
            .init(input: .init(from: "2018-04-29",
                               to: "2018-05-04",
                               sortCriteriaSegment: .numberOfHolidays),
                  output: .init(longWeekends: [LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-01")],
                                                                firstDate: dateManager.date(from: "2018-04-29"),
                                                                lastDate: dateManager.date(from: "2018-05-01"),
                                                                numberOfHolidays: 3,
                                                                containsNationalHoliday: true),
                                               LongWeekendModel(paidDays: [dateManager.date(from: "2018-05-02")],
                                                                firstDate: dateManager.date(from: "2018-05-02"),
                                                                lastDate: dateManager.date(from: "2018-05-04"),
                                                                numberOfHolidays: 3,
                                                                containsNationalHoliday: true)
                  ]),
                  desc: "when sortCriteriaSegment is numberOfHolidays and numberOfHolidays is the same")
        ]

        for testCase in testCases {
            setUp()
            mockUserDefaults[.fromDate] = dateManager.date(from: testCase.input.from)
            mockUserDefaults[.toDate] = dateManager.date(from: testCase.input.to)
            mockUserDefaults[.nationalHolidaySegment] = .undefined
            mockUserDefaults[.sortCriteriaSegment] = testCase.input.sortCriteriaSegment
            mockUserDefaults[.paidDaysCount] = 1
            mockUserDefaults[.minimumNumberOfHolidays] = 3
            viewModel.loadLongWeekend()

            for (output, longWeekend) in zip(testCase.output.longWeekends, viewModel.longWeekends) {
                XCTAssertEqual(output.paidDays, longWeekend.paidDays)
                XCTAssertEqual(output.firstDate, longWeekend.firstDate)
                XCTAssertEqual(output.lastDate, longWeekend.lastDate)
                XCTAssertEqual(output.numberOfHolidays, longWeekend.numberOfHolidays)
            }
        }
    }
}
