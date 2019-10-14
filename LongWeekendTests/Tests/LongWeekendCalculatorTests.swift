//
//  LongWeekendCalcuratorTests.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/14.
//  Copyright © 2019 funzin. All rights reserved.
//

import XCTest
@testable import LongWeekend

class LongWeekendCalcuratorTests: XCTestCase {

    var dateManeger: DateManager!
    var longWeekendCalcurator: LongWeekendCalcurator!

    override func setUp() {
        let calendar = Calendar(identifier: .gregorian)
        self.dateManeger = DateManager(calendar: calendar, formatter: DateManager.Formatter.holidayJpformatter)
        self.longWeekendCalcurator = LongWeekendCalcurator(calendar: calendar,
                                                           dateManager: dateManeger)
    }

    override func tearDown() {}

    func test_createLongWeekends() {

        struct Input {
            let from: String
            let to: String
            let paidDaysCount: Int
        }

        let testCases: [TestCase<Input, [LongWeekendModel]>] = [
            .init(input: .init(from: "2018-04-28", to: "2018-05-08", paidDaysCount: 2),
                  output: [.init(paidDays: ["2018-05-01", "2018-05-02"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-04-28"),
                                 lastDate: dateManeger.date(from: "2018-05-06"),
                                 numberOfHolidays: 9,
                                 containsNationalHoliday: true),
                           .init(paidDays: ["2018-05-02", "2018-05-07"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-05-02"),
                                 lastDate: dateManeger.date(from: "2018-05-07"),
                                 numberOfHolidays: 6,
                                 containsNationalHoliday: true),
                           .init(paidDays: ["2018-05-07", "2018-05-08"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-05-03"),
                                 lastDate: dateManeger.date(from: "2018-05-08"),
                                 numberOfHolidays: 6,
                                 containsNationalHoliday: true)],
                  desc: "when consecutive holidays are connected"),
            .init(input: .init(from: "2018-04-26", to: "2018-04-29", paidDaysCount: 2),
                  output: [.init(paidDays: ["2018-04-26", "2018-04-27"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-04-26"),
                                 lastDate: dateManeger.date(from: "2018-04-29"),
                                 numberOfHolidays: 4,
                                 containsNationalHoliday: true)],
                  desc: "when toDate is holiday"),
            .init(input: .init(from: "2018-04-20", to: "2018-04-23", paidDaysCount: 1),
                  output: [.init(paidDays: ["2018-04-20"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-04-20"),
                                 lastDate: dateManeger.date(from: "2018-04-22"),
                                 numberOfHolidays: 3,
                                 containsNationalHoliday: false),
                           .init(paidDays: ["2018-04-23"].map { dateManeger.date(from: $0) },
                                 firstDate: dateManeger.date(from: "2018-04-21"),
                                 lastDate: dateManeger.date(from: "2018-04-23"),
                                 numberOfHolidays: 3,
                                 containsNationalHoliday: false)],
                  desc: "when only one holiday"),
            .init(input: .init(from: "2018-04-23", to: "2018-04-21", paidDaysCount: 1),
                  output: [],
                  desc: "when the date is reversed")
        ]

        for testCase in testCases {
            setUp()
            let from = dateManeger.date(from: testCase.input.from)
            let to = dateManeger.date(from: testCase.input.to)
            let longWeekends = longWeekendCalcurator.createLongWeekends(paidDaysCount: testCase.input.paidDaysCount,
                                                                        from: from,
                                                                        to: to)

            XCTAssertEqual(testCase.output.count, longWeekends.count)
            for (output, longWeekend) in zip(testCase.output, longWeekends) {
                XCTAssertEqual(output.paidDays, longWeekend.paidDays)
                XCTAssertEqual(output.firstDate, longWeekend.firstDate)
                XCTAssertEqual(output.lastDate, longWeekend.lastDate)
                XCTAssertEqual(output.numberOfHolidays, longWeekend.numberOfHolidays)
            }
        }
    }
}
