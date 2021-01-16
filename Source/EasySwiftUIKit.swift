//
//  EasySwiftUIKit.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-01-16.
//

import Foundation
import UIKit

public func onTest(value: String) {
    print("dlkjflfjklkj \(value)")
}

extension UIView {
    @IBInspectable
    var cRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
