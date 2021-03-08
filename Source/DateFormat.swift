//
//  DateFormat.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-01-31
//EasySwiftUIKit Version (DateFormat implementation and integration at) - 1.0.2
//

import Foundation

public extension String {
    func dateFormat(toFormat argToFormat: String = "yyyy-MM-dd HH:mm:ss", withFormat argWithFormat: String = "yyyy-MM-dd HH:mm:ss") -> String! {
        var formedDate: String!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = argToFormat
        guard let convertedDate = dateFormatter.date(from: self) else {
            print("Unexpected date formete error: \(self) date formate by  \(argToFormat)")
            return nil
        }
        dateFormatter.dateFormat = argWithFormat
        formedDate = dateFormatter.string(from: convertedDate)
        return formedDate
    }
    func usageDateFormat() {
        //"2021-01-31".dateFormat(toFormat: "yyyy-MM-dd")
        print("=======================>\(String(describing: "2021-01-31".dateFormat(toFormat: "yyyy-MM-dd")))")
    }
}

public struct DateFormat: DateFormatConvertible {
    public let dateFormat: String
    
    public init() {
        dateFormat = ""
    }
    
    public init(format: DateFormatConvertible) {
        dateFormat = format.dateFormat
    }
    
    public init(formats: [DateFormatConvertible]) {
        dateFormat = formats.reduce("", +).dateFormat
    }
    
    public func year(_ style: YearStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func quarter(_ style: QuarterStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func month(_ style: MonthStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func day(_ style: DayStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func hour(_ style: HourStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func minute(_ style: MinuteStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func second(_ style: SecondStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func timezone(_ style: TimeZoneStyle) -> DateFormat {
        return DateFormat(formats: [dateFormat, style])
    }
    
    public func separator(_ separator: Separator) -> DateFormat {
        return DateFormat(formats: [dateFormat, separator])
    }
    
    public func string(_ string: String) -> DateFormat {
        return DateFormat(formats: [dateFormat, "'", string, "'"])
    }
}

public extension DateFormatter {
    func setDateFormat(_ format: DateFormatConvertible) {
        dateFormat = format.dateFormat
    }
}
//https://gist.github.com/fpg1503/f583ccfd8ac863b71c621843f5ca31b1
//https://github.com/malcommac/SwiftDate
