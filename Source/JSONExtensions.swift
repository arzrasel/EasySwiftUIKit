//
//  JSONExtensions.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-03-07
//

import Foundation

open class JSONHelper {
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: Data) -> (Bool, T?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: Data) -> (Bool, [T]?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: Any) -> (Bool, T?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: Any) -> (Bool, [T]?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: String) -> (Bool, T?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: String) -> (Bool, [T]?) {
        return JSONParser.parseJSON(dataModel: dataModel, jsonData: argJSONData)
    }
}
open class JSONParser {
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: Data) -> (Bool, T?) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: argJSONData)
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: Data) -> (Bool, [T]?) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: argJSONData)
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: Any) -> (Bool, T?) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: argJSONData)
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: Any) -> (Bool, [T]?) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: argJSONData)
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
    public static func parseJSON<T: Codable>(dataModel: T.Type, jsonData argJSONData: String) -> (Bool, T?) {
        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonData)
            let rawData = Data(argJSONData.utf8)
//            let jsonData = try JSONSerialization.jsonObject(with: rawData, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: rawData, options: [])
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
    public static func parseJSON<T: Codable>(dataModel: [T].Type, jsonData argJSONData: String) -> (Bool, [T]?) {
        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonData)
            let rawData = Data(argJSONData.utf8)
//            let jsonData = try JSONSerialization.jsonObject(with: rawData, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: rawData, options: [])
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(dataModel.self, from: jsonData)
            return (true, modelData)
        } catch {
            return (false, nil)
        }
    }
}
