//
//  DoubleExtensions.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-28
//

import Foundation

extension Double {
    public func roundToString(decimalPlace: Int) -> String {
        let dataForm = "%." + String(decimalPlace) + "f" as NSString
//        print(dataForm)
        return NSString(format: dataForm, self) as String
    }
    public func roundToDouble(decimalPlace: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlace))
        print(divisor)
        return (self * divisor).rounded() / divisor
    }
}
