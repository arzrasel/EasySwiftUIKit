//
//  DateFormatConvertible.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-03-08
//

import Foundation

protocol DateFormatConvertible {
    var dateFormat: String { get }
}

extension String: DateFormatConvertible {
    var dateFormat: String { return self }
}

func + (lhs: DateFormatConvertible, rhs: DateFormatConvertible) -> DateFormatConvertible {
    return lhs.dateFormat + rhs.dateFormat
}
