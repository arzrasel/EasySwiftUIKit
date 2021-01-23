//
//  FileUtils.swift
//  Rz Rasel
//
//  Created by Rz Rasel on 2021-01-21
//

import Foundation

//MARK:- Start of FileUtils class
public class FileUtils {
    //MARK:- Start of JSON class
    public class JSON {
//        typealias Handler = (Result<UIImage, NSError>) -> Void
        //        static func readFile(forName name: String) -> Data? {
//        static func readFile(from name: String) -> (Bool, Data) {
//        public static func readFile(forName name: String) -> Result<Data, Error> {
//            do {
//                if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
//                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
////                    return (false, jsonData)
//                    return Result{ jsonData }
//                }
//            } catch {
//            }
//            return .failure(DataError.invalid)
////            return (true, Data())
//        }
//        public static func readFileUsage() {
//            let data = FileUtils.JSON.readFile(forName: "JSONDataForHomeMain")
//            switch data {
//            case .success(let data):
//                print("JSON data \(data.jsonString())")
//            case .failure(let error):
//                print("Error \(error)")
//            }
//        }
        public static func readFile(forName name: String) -> Data? {
            do {
                if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        }
        public static func usageReadFile() {
        }
        public static func toString(from object: Any) -> String? {
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
                return nil
            }
            return String(data: data, encoding: String.Encoding.utf8)
        }
    }
    //MARK:- End of JSON class
}
//MARK:- End of FileUtils class

public enum DataError: Error {
    case invalid
}
//let jsonRaw = FileUtils.JSON.readFile(forName: "test") {
//    switch jsonRaw {
//    case .success(let modelData):
//        print("")
//    case .failure(let error):
//        print("")
//    }
//}
//Result<T, Error>
//class ImageProcessor {
//    typealias Handler = (Result<UIImage, NSError>) -> Void
//
//    func process(_ image: UIImage, then handler: @escaping Handler) {
//        do {
//            // Any error can be thrown here
//            var image = try transformer.transform(image)
//            image = try filter.apply(to: image)
//            handler(.success(image))
//        } catch let error as NSError {
//            // When using 'as NSError', Swift will automatically
//            // convert any thrown error into an NSError instance
//            handler(.failure(error))
//        }
//https://www.swiftbysundell.com/articles/the-power-of-result-types-in-swift/
//    }
//}
