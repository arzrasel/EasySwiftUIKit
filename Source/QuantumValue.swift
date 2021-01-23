//
//  QuantumValue.swift
//  Rz Rasel
//
//  Created by Rz Rasel on 2021-01-23
//

import Foundation

public enum QuantumValue: Decodable {
    case int(Int), double(Double), string(String)
    public init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw QuantumError.missingValue
    }
    enum QuantumError:Error {
        case missingValue
    }
}
public extension QuantumValue {
    var intValue: Int? {
        switch self {
        case .int(let value): return value
        case .double(let value): return Int(value)
        case .string(let value): return Int(value)
        }
    }
    var doubleValue: Double {
        switch self {
        case .int(let int): return Double(int)
        case .double(let value): return value
        case .string(let string): return Double(string)!
        }
    }
    var stringValue: String {
        switch self {
        case .int(let int): return String(int)
        case .double(let value): return String(value)
        case .string(let string): return string
        }
    }
    //var idAsString: String {
    //    switch id {
    //    case .string(let string): return string
    //    case .int(let int): return String(int)
    //    }
    //}
}
public enum CodableType: Codable {
    case string(String)
    case arrString([String])
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
            return
        }
        if let arrString = try? container.decode([String].self) {
            self = .arrString(arrString)
            return
        }
        throw DecodingError.typeMismatch(CodableType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CodableType"))
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .arrString(let arrString):
            try container.encode(arrString)
        }
    }
}
