// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Close
  internal static let close = L10n.tr("Localizable", "close")
  /// Contains nationalholiday
  internal static let containsNationalHoliday = L10n.tr("Localizable", "containsNationalHoliday")
  /// Date
  internal static let date = L10n.tr("Localizable", "date")
  /// Days
  internal static let days = L10n.tr("Localizable", "days")
  /// from
  internal static let fromDate = L10n.tr("Localizable", "fromDate")
  /// Holiday period
  internal static let holidayPeriod = L10n.tr("Localizable", "holidayPeriod")
  /// LongWeekend
  internal static let longWeekend = L10n.tr("Localizable", "longWeekend")
  /// Minimum number of holidays
  internal static let minimumNumberOfHolidays = L10n.tr("Localizable", "minimumNumberOfHolidays")
  /// National holiday
  internal static let nationalHoliday = L10n.tr("Localizable", "nationalHoliday")
  /// Not contain nationalholiday
  internal static let notContainNationalHoliday = L10n.tr("Localizable", "notContainNationalHoliday")
  /// Number of holidays
  internal static let numberOfHolidays = L10n.tr("Localizable", "numberOfHolidays")
  /// Number of paid days
  internal static let numberOfPaidDays = L10n.tr("Localizable", "numberOfPaidDays")
  /// Paid days
  internal static let paidDays = L10n.tr("Localizable", "paidDays")
  /// Save
  internal static let save = L10n.tr("Localizable", "save")
  /// Saved!
  internal static let savedSetting = L10n.tr("Localizable", "savedSetting")
  /// Setting
  internal static let setting = L10n.tr("Localizable", "setting")
  /// Sort criteria
  internal static let sortCriteria = L10n.tr("Localizable", "sortCriteria")
  /// to
  internal static let toDate = L10n.tr("Localizable", "toDate")
  /// Unspecified
  internal static let unspecified = L10n.tr("Localizable", "unspecified")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
