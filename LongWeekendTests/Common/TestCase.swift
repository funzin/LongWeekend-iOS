//
//  TestCase.swift
//  LongWeekendTests
//
//  Created by funzin on 2019/10/21.
//

import Foundation

struct TestCase<Input, Output> {
    let input: Input
    let output: Output
    let desc: String

    init(input: Input, output: Output, desc: String = "") {
        self.input = input
        self.output = output
        self.desc = desc
    }
}
