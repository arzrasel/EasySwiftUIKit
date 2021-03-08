//
//  DateStyles.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-03-08
//

import Foundation

//TODO Adopt TR-35 (http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns)
//MARK :- Styles
enum YearStyle: String, DateFormatConvertible {
    case noPadding = "y"
    case twoDigits = "yy"
    case fourDigits = "yyyy"

    var dateFormat: String { return rawValue }
}

enum QuarterStyle: String, DateFormatConvertible {
    case number = "Q"
    case zeroPaddedNumber = "QQ"
    case qAndNumber = "QQQ"
    case spelledOut = "QQQQ"

    var dateFormat: String { return rawValue }
}

enum MonthStyle: String, DateFormatConvertible {
    case number = "M"
    case zeroPaddedNumber = "MM"
    case shortName = "MMM"
    case fullName = "MMMM"
    case narrowName = "MMMMM"

    var dateFormat: String { return rawValue }
}

enum DayStyle: String, DateFormatConvertible {
    case number = "d"
    case zeroPaddedNumber = "dd"
    case dayOfWeekInMonth = "F"
    case shortDayOfWeek = "E"
    case fullDayOfWeek = "EEEE"
    case narrowDayOfWeek = "EEEEE"

    var dateFormat: String { return rawValue }
}

enum HourStyle: String, DateFormatConvertible {
    case twelveHour = "h"
    case zeroPaddedTwelveHour = "hh"
    case twentyFourHour = "H"
    case zeroPaddedTwentyFourHour = "HH"
    case AMorPM = "a"

    var dateFormat: String { return rawValue }
}

enum MinuteStyle: String, DateFormatConvertible {
    case number = "m"
    case zeroPaddedNumber = "mm"

    var dateFormat: String { return rawValue }
}

enum SecondStyle: String, DateFormatConvertible {
    case number = "s"
    case zeroPaddedNumber = "ss"

    var dateFormat: String { return rawValue }
}

enum TimeZoneStyle: String, DateFormatConvertible {
    case threeLetterName = "zzz"
    case expandedName = "zzzz"
    case RFC822 = "Z"
    case ISO8601 = "ZZZZZ"

    var dateFormat: String { return rawValue }
}

enum Separator: String, DateFormatConvertible {
    case dash = "-"
    case slash = "/"
    case colon = ":"
    case space = " "

    var dateFormat: String { return rawValue }
}
