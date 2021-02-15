//
//  MimeType.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-13
//

import Foundation

extension NSURL {
    public func mimeType() -> String {
        return MimeType(ext: self.pathExtension)
    }
}
extension NSString {
    public func mimeType() -> String {
        return MimeType(ext: self.pathExtension)
    }
}
extension String {
    public func mimeType() -> String {
        return (self as NSString).mimeType()
    }
}

