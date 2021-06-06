//
//  DateManagerTests.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/21.
//

import XCTest

@testable import LongWeekend
class DateManagerTests: XCTestCase {
    var dateManager: DateManager!

    override func setUp() {
        let calendar = Calendar(identifier: .gregorian)
        dateManager = DateManager(calendar: calendar,
                                  formatter: DateManager.Formatter.holidayJpformatter)
    }

    override func tearDown() {}

    func test_makeAllDays() {
        struct Input {
            let from: String
            let to: String
        }

        struct Output {
            let count: Int
            let from: Date?
            let to: Date?
        }

        let testCases: [TestCase<Input, Output>] = [
            .init(input: .init(from: "2018-04-23", to: "2018-04-21"),
                  output: .init(count: 0,
                                from: nil,
                                to: nil),
                  desc: "The date is reversed"),
            .init(input: .init(from: "2018-01-01", to: "2018-01-31"),
                  output: .init(count: 31,
                                from: dateManager.date(from: "2018-01-01"),
                                to: dateManager.date(from: "2018-01-31")))
        ]

        for testCase in testCases {
            setUp()
            let allDays = dateManager.makeAllDays(from: dateManager.date(from: testCase.input.from),
                                                  to: dateManager.date(from: testCase.input.to))
            XCTAssertEqual(allDays.count, testCase.output.count)
            XCTAssertEqual(allDays.first, testCase.output.from)
            XCTAssertEqual(allDays.last, testCase.output.to)
        }
    }

    func test_extractWeekends() {
        let from = dateManager.date(from: "2018-01-01")
        let to = dateManager.date(from: "2018-01-08")

        let allDays = dateManager.makeAllDays(from: from, to: to)
        let weekends = dateManager.extractWeekends(from: allDays)

        XCTAssertEqual(weekends.count, 2)
        XCTAssertEqual(weekends.first, dateManager.date(from: "2018-01-06"))
        XCTAssertEqual(weekends.last, dateManager.date(from: "2018-01-07"))
    }

    func test_makeNationalHolidays() {
        let from = dateManager.date(from: "2018-01-01")
        let to = dateManager.date(from: "2018-01-31")
        let nationalHolidays = dateManager.makeNationalHolidays(from: from, to: to)

        XCTAssertEqual(nationalHolidays.count, 2)
        XCTAssertEqual(nationalHolidays.first, dateManager.date(from: "2018-01-01"))
        XCTAssertEqual(nationalHolidays.last, dateManager.date(from: "2018-01-08"))
    }

    func test_createHolidaysArray() {
        let holidaysArray = dateManager.createHolidaysArray(holidays: ["2018-01-01",
                                                                       "2018-01-06", "2018-01-07",
                                                                       "2018-01-08", "2018-01-13", "2018-01-14"]
                .map { dateManager.date(from: $0) })

        XCTAssertEqual(holidaysArray.count, 3)
        XCTAssertEqual(holidaysArray[0], ["2018-01-01"].map { dateManager.date(from: $0) })
        XCTAssertEqual(holidaysArray[1], ["2018-01-06", "2018-01-07", "2018-01-08"].map { dateManager.date(from: $0) })
        XCTAssertEqual(holidaysArray[2], ["2018-01-13", "2018-01-14"].map { dateManager.date(from: $0) })
    }
}
