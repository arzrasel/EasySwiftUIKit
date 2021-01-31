//
//  DateFormat.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-01-31
//Version (dateFormat implementation and integration at): 1.0.2
//

import Foundation

extension String {
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
    public static func usageDateFormat() {
        //"2021-01-31".dateFormat(toFormat: "yyyy-MM-dd")
        print("=======================>\(String(describing: "2021-01-31".dateFormat(toFormat: "yyyy-MM-dd")))")
    }
}
