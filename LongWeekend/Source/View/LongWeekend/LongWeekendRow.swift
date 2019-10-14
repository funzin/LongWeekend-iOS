//
//  LongWeekendRow.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/21.
//

import SwiftUI

struct LongWeekendRow: View {
    var longWeekend: LongWeekendModel

    var body: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading, spacing: 8) {
                HStack {
                    Text("\(L10n.numberOfHolidays): ")
                    Text("\(longWeekend.numberOfHolidays)\(L10n.days)")
                        .font(Font.bold(.system(size: 16))())
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(L10n.holidayPeriod):")
                    Text("\(DateManager.shared.string(from: longWeekend.firstDate))~\(DateManager.shared.string(from: longWeekend.lastDate))")
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(L10n.paidDays): ")
                    Text(longWeekend.paidDays.map { "・\(DateManager.shared.string(from: $0))" }.joined(separator: "\n"))
                        .lineLimit(nil)
                }
            }
            .font(Font.system(size: 16))
            .foregroundColor(Color(UIColor.label))
            Spacer()
        }
        .padding(15)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(13, antialiased: false)
    }
}
