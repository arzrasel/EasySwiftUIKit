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
internal var isDebug = false
public var setDebugLod: Bool {
    get{return isDebug}
    set{isDebug = newValue}
}
public func debugLog(object: Any, message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    if isDebug == false {
        return
    }
    let className = (fileName as NSString).lastPathComponent
    print("DEBUG_LOG_PRINT: " + message + " <\(className)> \(functionName) [\(lineNumber)] | \(object)")
}
