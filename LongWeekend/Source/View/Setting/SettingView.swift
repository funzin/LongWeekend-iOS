//
//
//  SettingView.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/21.
//

import SwiftUI

struct SettingView: View {

    @Environment(\.presentationMode) var presentation
    @ObservedObject(initialValue: SettingViewModel()) var viewModel: SettingViewModel
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text(L10n.numberOfPaidDays)) {
                    Stepper(value: $viewModel.paidDaysCount, in: 1...100, label: { Text("\(viewModel.paidDaysCount)\(L10n.days)")})
                }
                .padding(10)
                Section(header: Text(L10n.minimumNumberOfHolidays)) {
                    Stepper(value: $viewModel.minimumNumberOfHolidays, in: 3...100, label: { Text("\(viewModel.minimumNumberOfHolidays)\(L10n.days)")})
                }
                .padding(10)
                Section(header: Text(L10n.nationalHoliday)) {
                    Picker(selection: $viewModel.nationalHolidaySegment, label: Text("")) {
                        Text(L10n.unspecified).tag(NationalHolidaySegment.undefined)
                        Text(L10n.containsNationalHoliday).tag(NationalHolidaySegment.containsNationalHoliday)
                        Text(L10n.notContainNationalHoliday).tag(NationalHolidaySegment.notContainNationalHoliday)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .padding(10)
                Section(header: Text(L10n.sortCriteria)) {
                    Picker(selection: $viewModel.sortCriteriaSegment, label: Text("")) {
                        Text(L10n.date).tag(SortCriteriaSegment.date)
                        Text(L10n.numberOfHolidays).tag(SortCriteriaSegment.numberOfHolidays)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .padding(10)
                Section(header: Text(L10n.date)) {
                    VStack(alignment: .leading) {
                        Text("\(L10n.fromDate): ")
                        DatePicker(selection: $viewModel.fromDate, displayedComponents: .date) {
                            Text("")
                        }
                        .labelsHidden()
                        .padding(10)
                        Text("\(L10n.toDate): ")
                        DatePicker(selection: $viewModel.toDate, displayedComponents: .date) {
                            Text("")
                        }
                        .labelsHidden()
                        .padding(10)
                    }
                }
                .padding(10)
            }
            .navigationBarTitle(L10n.setting)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented = true
                    self.viewModel.save()
                }) {
                    Text(L10n.save)
                }
                .alert(isPresented: $isPresented, content: {
                    Alert(title: Text(L10n.savedSetting),
                          message: nil,
                          dismissButton: .default(Text(L10n.close),
                                                  action: { self.presentation.wrappedValue.dismiss() }))
                })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
