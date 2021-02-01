//
//  UserDefaultsExtension.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-01
//EasySwiftUIKit Version (UserDefaults implementation and integration at) - 1.0.3
//

import Foundation

public extension UserDefaults {
    
    /// RZ RASEL: Generic getter and setter for UserDefaults.
    subscript(key: String) -> AnyObject? {
        get {
            return object(forKey: key) as AnyObject?
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// RZ RASEL: Date from UserDefaults.
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
