//
//  EasySwiftUIKit.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-01-16
//
// EasySwiftUIKit Version - '1.0.1'
//  Version - '1.0.1'

import Foundation
import UIKit


fileprivate func <<T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
public extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL: URL = URL(string: gifUrl) else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)

        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        delay = delayObject as! Double

        if delay < 0.1 {
            delay = 0.1
        }

        return delay
    }

    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }

        if a < b {
            let c = a
            a = b
            b = c
        }

        var rest: Int
        while true {
            rest = a! % b!

            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }

    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }

            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)

        return animation
    }
    //iOSDevCenters+GIF.swift
}
public extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
public extension UIImageView {
    func onLoad(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func onLoad(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        onLoad(from: url, contentMode: mode)
    }
    //imageView.downloaded(from: "https://transition.jpg")
}
public extension UIImage {
    func scaled(with scale: CGFloat) -> UIImage? {
        // size has to be integer, otherwise it could get white lines
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
public extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
public extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.width)
    }
}
public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
public struct Padding {
    var left: CGFloat = 0.0
    var top: CGFloat = 0.0
    var right: CGFloat = 0.0
    var bottom: CGFloat = 0.0
}
public extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    func viewSize(font: UIFont, viewWidth: CGFloat, minLineSize: CGSize, padding: Padding) -> CGSize {
        return labelSize(font: font, viewWidth: viewWidth, minLineSize: minLineSize, padding: padding)
    }
    func labelSize(font: UIFont, viewWidth: CGFloat, minLineSize: CGSize, padding: Padding) -> CGSize {
        let viewSize = CGSize(width: viewWidth, height: 9999.0)
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self
        label.font = font
        var size = label.sizeThatFits(viewSize)
        size.width = max(minLineSize.width, size.width) + padding.left + padding.right
        size.height = max(minLineSize.height, size.height) + padding.top + padding.bottom
        return size
    }
    func urlEncode(escaped escapedString: String = "-._~/?%$!:") -> String {
        //let unreserved = "-._~/?%$!:"
        let unreserved = escapedString
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
        return escapedString!
    }
    func toJSON() -> Data {
        return self.data(using: .utf8)!
    }
    func jsonDecode<T: Decodable>() throws -> T {
        return try self.toJSON().jsonDecode()
    }
    func jsonDecode<T: Codable>() throws -> T {
        return try self.toJSON().jsonDecode()
    }
    func storeData(forKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: forKey)
        defaults.synchronize()
    }
    func retrieveData() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: self)!
    }
    func removeData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: self)
        defaults.synchronize()
    }
    func removeAllData() {
        let domain = Bundle.main.bundleIdentifier!
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    func dataStore(forKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: forKey)
        defaults.synchronize()
    }
    func dataRetrieve() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: self) ?? ""
    }
    func dataRemove() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: self)
        defaults.synchronize()
    }
    func dataRemoveAll() {
        let domain = Bundle.main.bundleIdentifier!
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
public extension String {
    func matchesRegex(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
    func matchRegex(regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.map { match in
            return String(self[Range(match.range, in: self)!])
        }
    }
    func regexMatch(regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.map { match in
            return String(self[Range(match.range, in: self)!])
        }
        //        let mobilePattern: String = "^(?:\\+88|88)?(01[3-9]\\d{8})$"
        //        mobileNumber.matchRegex(regex: mobilePattern)
    }
    var length: Int {
        return self.count
    }
    var unicodeLength: Int {
        return self.unicodeScalars.count
    }
    var utf16Length: Int {
        return self.utf16.count
    }
    var utf8Length: Int {
        return self.utf8.count
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
public extension Data {
    func jsonString() -> String {
        return String(data: self, encoding: .utf8)!
    }
    func jsonDecode<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
    func jsonDecode<T: Codable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
    func parseJSON<T: Decodable>(jsonData: Data, returnModelType: T.Type) -> Result<T, Error> {
        return Result { try JSONDecoder().decode(returnModelType.self, from: jsonData) }
//        do {
//            let decodedData = try JSONDecoder().decode(returnModelType.self, from: jsonData)
//            return decodedData
//        } catch {
//            print("decode error")
//            return nil
//        }
        //https://stackoverflow.com/questions/60889362/swift-jsondecoder-passing-class-type-as-parameter-to-decode-model-using-gene
    }
}
public extension Encodable {
    func jsonEncode() -> Data {
        var jsonData: Data!
        do {
            let jsonEncoder = JSONEncoder()
            jsonData = try jsonEncoder.encode(self)
            return jsonData
        } catch { return jsonData }
    }
    func jsonString() -> String {
        return self.jsonEncode().jsonString()
    }
    //
    //    debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: sentences.jsonString())) line: \(#line)")
    //    do {
    //        let decodedUser: [Sentence] = try sentences.jsonString().jsonDecode()
    //        debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: decodedUser)) line: \(#line)")
    //    } catch {
    //        print(error)
    //    }
    //
    //https://stackoverflow.com/questions/64841126/cannot-convert-value-of-type-codable-aka-decodable-encodable-to-expected/64841146
    //
    //    var sentences = [Sentence(sentence: "Hello world", lang: "en"),
    //                     Sentence(sentence: "Hallo Welt", lang: "de")]
    //
    //    do {
    //        let jsonData = try JSONEncoder().encode(sentences)
    //        let jsonString = String(data: jsonData, encoding: .utf8)!
    //        debugPrint("DEBUG_LOG_PRINT: jsonString \(String(describing: jsonString)) line: \(#line)")
    //        //
    //        let defaults = UserDefaults.standard
    //        defaults.set(jsonString, forKey: "sentences")
    //        let sentencesBack = defaults.string(forKey: "sentences")
    //        let data = sentencesBack!.data(using: .utf8)
    //        debugPrint("DEBUG_LOG_PRINT: jsonString \(String(describing: data)) line: \(#line)")
    //
    //        // and decode it back
    //        let decodedSentences = try JSONDecoder().decode([Sentence].self, from: data!)
    //        debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: decodedSentences)) line: \(#line)")
    //        print(decodedSentences)
    //    } catch { print(error) }
    //
    //    struct Sentence : Codable {
    //        var sentence : String
    //        var lang : String
    //    }
    //
    //    private func parseJson<T: Decodable>(data: Data, type: T.Type) -> T? {
    //        do {
    //            return try JSONDecoder().decode(type.self, from: data)
    //        } catch {
    //            print("JSON decode error:", error)
    //            return nil
    //        }
    //    }
    //    private func parseJson<T: Decodable>(data: Data) -> T? {
    //        do {
    //            return try JSONDecoder().decode(T.self, from: data)
    //        } catch {
    //            print("JSON decode error:", error)
    //            return nil
    //        }
    //    }
    //
    //
    //    var searchWord = [SearchWord(word: "Bag"),
    //                     SearchWord(word: "Shoe")]
    //
    //    debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: searchWord)) line: \(#line)")
    //    searchWord.jsonString().storeData(forKey: "search_word")
    //    do {
    //        let search: [SearchWord] = try "search_word".retrieveData().jsonDecode()
    //        debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: search)) line: \(#line)")
    //    } catch {
    //        debugPrint("DEBUG_LOG_PRINT: Error line: \(#line)")
    //    }
    //
    //    struct SearchWord : Codable {
    //        var word : String
    //    }
    //
    //    debugPrint("DEBUG_LOG_PRINT: decodedSentences \(String(describing: searchWordListTemp)) line: \(#line)")
    //    searchWordListTemp.jsonString().dataStore(forKey: "search_word_list")
}
public extension Int {
    func format(format: String) -> String {
        return String(format: "%\(format)d", self)
    }
}

public extension Double {
    func format(format: String) -> String {
        return String(format: "%\(format)f", self)
    }
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
public var dismissDialogController: (() -> Void)!
public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func panGestureRightToLeft() {
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(onHandlePanGesture(recognizer:)))
        self.view.addGestureRecognizer(panGesture)
    }
    @objc func onHandlePanGesture(recognizer: UIPanGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    func showDialogController(dialogStoryboardName argStoryboardName: String, withDialogControllerIdentifier argIdentifier: String) -> UIViewController {
        return showDialogController(dialogStoryboardName: argStoryboardName, withDialogControllerIdentifier: argIdentifier, blurAmount: 0.5, canceledOnTouchOutside: false)
    }
    func showDialogController(dialogStoryboardName argStoryboardName: String, withDialogControllerIdentifier argIdentifier: String, blurAmount argBlurAmount: CGFloat) -> UIViewController {
        return showDialogController(dialogStoryboardName: argStoryboardName, withDialogControllerIdentifier: argIdentifier, blurAmount: argBlurAmount, canceledOnTouchOutside: false)
    }
    func showDialogController(dialogStoryboardName argStoryboardName: String, withDialogControllerIdentifier argIdentifier: String, canceledOnTouchOutside argCanceledOnTouchOutside: Bool) -> UIViewController {
        return showDialogController(dialogStoryboardName: argStoryboardName, withDialogControllerIdentifier: argIdentifier, blurAmount: 0.5, canceledOnTouchOutside: argCanceledOnTouchOutside)
    }
    func showDialogController(dialogStoryboardName argStoryboardName: String, withDialogControllerIdentifier argIdentifier: String, blurAmount argBlurAmount: CGFloat = 0.5, canceledOnTouchOutside argCanceledOnTouchOutside: Bool = false) -> UIViewController {
        //navigate to New View Controller
        let storyBoard: UIStoryboard = UIStoryboard(name: argStoryboardName, bundle: nil)
        let dialogController = storyBoard.instantiateViewController(withIdentifier: argIdentifier)
        //        dialogController.parentController = self
        self.addChild(dialogController)
        dialogController.view.backgroundColor = UIColor.black.withAlphaComponent(argBlurAmount)
        dialogController.view.frame = self.view.frame
        self.view.addSubview(dialogController.view)
        dialogController.didMove(toParent: self)
        if argCanceledOnTouchOutside == true {
            let tap = UITapGestureRecognizer(target: dialogController, action: #selector(UIViewController.onTapDismissDialogController))
            //            tap.cancelsTouchesInView = false
            dialogController.view.addGestureRecognizer(tap)
        }
        return dialogController
    }
    func closeDialogController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        //        self.willMove(toParent: nil)
        //        self.view.removeFromSuperview()
        //        self.removeFromParent()
    }
    func closeDialogController(dialogStoryboardName argStoryboardName: String, withDialogControllerIdentifier argIdentifier: String) {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    //    func closeDialogController(dialogController argDialogController: UIViewController) {
    //        argDialogController.willMove(toParent: nil)
    //        argDialogController.view.removeFromSuperview()
    //        argDialogController.removeFromParent()
    //    }
    @objc private func onTapDismissDialogController() {
        //        view.endEditing(true)
        dismissDialogController?()
        closeDialogController()
    }
}
public extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false)
    }

    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    func presentFromLeft(withPushControllerIdentifier argIdentifier: String) -> UIViewController{
        let pushController = self.storyboard!.instantiateViewController(withIdentifier: argIdentifier)
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        pushController.modalPresentationStyle = .overCurrentContext
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(pushController, animated: false, completion: nil)
        return pushController
    }
    func dismissFromRight() {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    func pushFromLeft(withPushControllerIdentifier argIdentifier: String) -> UIViewController{
        let pushController = self.storyboard!.instantiateViewController(withIdentifier: argIdentifier)
        let transition:CATransition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        //        transition.subtype = CATransitionSubtype.fromRight
        //        pushController.modalPresentationStyle = .overCurrentContext
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(pushController, animated: true)
        //        pushController.modalPresentationStyle = .overCurrentContext
        //        present(pushController, animated: true, completion: nil)
        return pushController
    }
    func pushFromLeft(dialogStoryboardName argStoryboardName: String, withPushControllerIdentifier argIdentifier: String) -> UIViewController{
        let storyBoard: UIStoryboard = UIStoryboard(name: argStoryboardName, bundle: nil)
        //        let obj = self.storyboard?.instantiateViewController(withIdentifier: "VCHomeHamburger")as! VCHomeHamburger
        let pushController = storyBoard.instantiateViewController(withIdentifier: argIdentifier)
        let transition:CATransition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        //        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(pushController, animated: true)
        return pushController
    }
    func popFromRight() {
        let transition:CATransition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        //        transition.subtype = CATransitionSubtype.fromLeft
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: true)
    }
}
public extension CATransition {
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}
public extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    func rounded(with color: UIColor, width: CGFloat) -> UIImage? {

        guard let cgImage = cgImage?.cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : .zero, y: isPortrait ? ((size.height-size.width)/2).rounded(.down) : .zero), size: breadthSize)) else { return nil }

        let bleed = breadthRect.insetBy(dx: -width, dy: -width)
        let format = imageRendererFormat
        format.opaque = false

        return UIGraphicsImageRenderer(size: bleed.size, format: format).image { context in
            UIBezierPath(ovalIn: .init(origin: .zero, size: bleed.size)).addClip()
            var strokeRect =  breadthRect.insetBy(dx: -width/2, dy: -width/2)
            strokeRect.origin = .init(x: width/2, y: width/2)
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
                .draw(in: strokeRect.insetBy(dx: width/2, dy: width/2))
            context.cgContext.setStrokeColor(color.cgColor)
            let line: UIBezierPath = .init(ovalIn: strokeRect)
            line.lineWidth = width
            line.stroke()
        }
    }
    //    let profilePicture = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
    //    let pp = profilePicture.rounded(with: .red, width: 10)
}
//extension UIView {
//  @IBInspectable var cRadius: CGFloat {
//   get{
//        return layer.cornerRadius
//    }
//    set {
//        layer.cornerRadius = newValue
//        layer.masksToBounds = newValue > 0
//    }
//  }
//  @IBInspectable var bWidth: CGFloat {
//    get {
//        return layer.borderWidth
//    }
//    set {
//        layer.borderWidth = newValue
//    }
//  }
//  @IBInspectable var bColor: UIColor? {
//    get {
//        return UIColor(cgColor: layer.borderColor!)
//    }
//    set {
//        layer.borderColor = newValue?.cgColor
//    }
//  }
//}
public enum RoundType {
    case top
    case none
    case bottom
    case both
}

public extension UIView {
    func round(with type: RoundType, radius: CGFloat = 3.0) {
        var corners: UIRectCorner

        switch type {
        case .top:
            corners = [.topLeft, .topRight]
        case .none:
            corners = []
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .both:
            corners = [.allCorners]
        }
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
public extension UIVisualEffectView {

    func fadeInEffect(_ style:UIBlurEffect.Style = .light, withDuration duration: TimeInterval = 1.0) {
        if #available(iOS 10.0, *) {
            let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
                self.effect = UIBlurEffect(style: style)
            }

            animator.startAnimation()
        }else {
            // Fallback on earlier versions
            UIView.animate(withDuration: duration) {
                self.effect = UIBlurEffect(style: style)
            }
        }
    }

    func fadeOutEffect(withDuration duration: TimeInterval = 1.0) {
        if #available(iOS 10.0, *) {
            let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                self.effect = nil
            }

            animator.startAnimation()
            animator.fractionComplete = 1
        }else {
            // Fallback on earlier versions
            UIView.animate(withDuration: duration) {
                self.effect = nil
            }
        }
    }
    //https://gist.github.com/gunhansancar/a5153cd4df9e81dd95ad04731b4ddf43
}
public extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: opacity)
    }
}
@IBDesignable
public class DesignableView: UIView {
}

@IBDesignable
public class DesignableButton: UIButton {
}

@IBDesignable
public class DesignableLabel: UILabel {
}

public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
public extension UILabel {
    @IBInspectable
    var StrikeThrough: Bool {
        get {
            return self.StrikeThrough
        }
        set {
            self.strikeThrough(isStrikeThrough: newValue)
        }
    }
    @IBInspectable
    var HTMLText: String {
        get {
            return self.HTMLText
        }
        set {
            let htmlText = newValue
            self.attributedText = htmlText.htmlToAttributedString
        }
    }
}
@IBDesignable
public class uiLabel: UILabel {

    @IBInspectable var StrikeOutThrough: Bool = false {
        didSet{
            strikeThrough(isStrikeThrough: StrikeOutThrough)
        }
    }
}
public extension UIButton {
    @IBInspectable
    var alignImageRight: Bool {
        get {
            return self.alignImageRight
        }
        set {
            let isRight = newValue
//            if isRight == true {
//                self.semanticContentAttribute = .forceLeftToRight
//            } else {
//                self.semanticContentAttribute = .forceRightToLeft
//            }
            if isRight == true {
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.imageView?.frame.size.width ?? 0), bottom: 0, right: self.imageView?.frame.size.width ?? 0);
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel?.frame.size.width ?? 0, bottom: 0, right: -(self.titleLabel?.frame.size.width ?? 0));
            } else {
//                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.imageView?.frame.size.width ?? 0), bottom: 0, right: self.imageView?.frame.size.width ?? 0);
//                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel?.frame.size.width ?? 0, bottom: 0, right: -(self.titleLabel?.frame.size.width ?? 0));
            }
//            self.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
//            self.attributedText = htmlText.htmlToAttributedString
        }
        //https://stackoverflow.com/questions/7100976/how-do-i-put-the-image-on-the-right-side-of-the-text-in-a-uibutton
    }
//    func alignImageRight() {
//        if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
//            semanticContentAttribute = .forceRightToLeft
//        }
//        else {
//            semanticContentAttribute = .forceLeftToRight
//        }
//    }
}
public extension UIView {
    func cornerRadiusForm(cornerRadius argcornerRadius: CGFloat, cornersRounded argRoundedCorners: UIRectCorner) {
        self.layer.cornerRadius = argcornerRadius
        self.layer.masksToBounds = true
        //
        var maskedCorners: CACornerMask = []
        if argRoundedCorners.contains(UIRectCorner.topLeft) {
            maskedCorners.insert(CACornerMask.layerMinXMinYCorner)
        }
        if argRoundedCorners.contains(UIRectCorner.topRight) {
            maskedCorners.insert(CACornerMask.layerMaxXMinYCorner)
        }
        if argRoundedCorners.contains(UIRectCorner.bottomLeft) {
            maskedCorners.insert(CACornerMask.layerMinXMaxYCorner)
        }
        if argRoundedCorners.contains(UIRectCorner.bottomRight) {
            maskedCorners.insert(CACornerMask.layerMaxXMaxYCorner)
        }
        self.layer.maskedCorners = maskedCorners
        //        self.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        //        self.layer.borderWidth = 1.0
    }
    func cornerRadiusFormUsage() {
        debugPrint("view.cornerRadiusForm(cornerRadius: 20.0, cornersRounded: [.topLeft, .topRight, .bottomLeft, .bottomRight])")
        debugPrint("view.cornerRadiusForm(cornerRadius: 12.0, cornersRounded: [.topLeft, .topRight])")
    }
}
public extension UIView {
    func makeBlurEffectView(style:UIBlurEffect.Style? = nil) -> UIVisualEffectView{
        let blurEffectView = UIVisualEffectView()

        if let style = style {
            blurEffectView.effect = UIBlurEffect(style: style)
        }

        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }

    func addBlurEffectView(sendBack:Bool = false) -> UIVisualEffectView{
        let blurEffectView = makeBlurEffectView()
        self.addSubview(blurEffectView)

        if sendBack {
            self.sendSubviewToBack(blurEffectView)
        }

        return blurEffectView
    }
}
public extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range:NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
public extension UILabel {
    func strikeThrough() {
        self.strikeThrough(isStrikeThrough: true)
    }
    func strikeThrough(isStrikeThrough: Bool) {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText {
                let txt = attributedStringText.string
                self.attributedText = nil
                self.text = txt
                return
            }
        }
    }
}
public extension String {
    func trimmed() -> String {
        return self.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: " ", options: .regularExpression, range: nil)
    }
    func titlecased() -> String {
        if self.trimmingCharacters(in: .whitespacesAndNewlines).count <= 1 {
            return self.uppercased()
        }
        let sentenceArray = self.trimmingCharacters(in: .whitespacesAndNewlines).trimmed().lowercased().components(separatedBy: " ")
        var convertedSentence = ""
        for var sentence in sentenceArray {
            if sentence.first == " "{
                sentence.removeFirst()
            }

            if sentence.first != nil{
                convertedSentence += sentence.prefix(1).uppercased() + String(sentence.dropFirst() + " ")
            }
        }
        return convertedSentence
        //        if self.count <= 1 {
        //            return self.uppercased()
        //        }
        //        self.lowercased()
        //        let regex = try! NSRegularExpression(pattern: "(?=\\S)[A-Z]", options: [])
        //        let range = NSMakeRange(1, self.count - 1)
        //        var titlecased = regex.stringByReplacingMatches(in: self, range: range, withTemplate: " $0")
        //
        //        for i in titlecased.indices {
        //            if i == titlecased.startIndex || titlecased[titlecased.index(before: i)] == " " {
        //                titlecased.replaceSubrange(i...i, with: String(titlecased[i]).uppercased())
        //            }
        //        }
        //        return titlecased
    }
    func sentencecased() -> String {
        if self.trimmingCharacters(in: .whitespacesAndNewlines).count <= 1 {
            return self.uppercased()
        }
        let sentenceArray = self.trimmingCharacters(in: .whitespacesAndNewlines).trimmed().lowercased().components(separatedBy: ".")
        var convertedSentence = ""
        for var sentence in sentenceArray {
            if sentence.first == " "{
                sentence.removeFirst()
            }

            if sentence.first != nil{
                convertedSentence += sentence.prefix(1).uppercased() + String(sentence.dropFirst() + "." + " ")
            }
        }
        return convertedSentence
    }
}
public func logData(object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) -> String {
    let className = (fileName as NSString).lastPathComponent
    return "<\(className)> \(functionName) [#\(lineNumber)] | \(object)"
}
public func logInfo(object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) -> String {
    let className = (fileName as NSString).lastPathComponent
    return "<\(className)> \(functionName) [#\(lineNumber)] | \(object)"
}
internal var isDebug = false
public var isDebugLog: Bool {
    get{return isDebug}
    set{isDebug = newValue}
}
//public var setDebugLog: Bool {
//    get{return isDebug}
//    set{isDebug = newValue}
//}
public func setDebugLog(isDebug argIsDebug: Bool) -> Bool {
    isDebug = argIsDebug
    return isDebug
}
public func debugLogPrint(object: Any, message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    if isDebug == false {
        return
    }
    let className = (fileName as NSString).lastPathComponent
    print("DEBUG_LOG_PRINT: " + message + " <\(className)> \(functionName) [\(lineNumber)] | \(object)")
}
public func debugLog(object: Any, message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    if isDebug == false {
        return
    }
    let className = (fileName as NSString).lastPathComponent
    print("DEBUG_LOG_PRINT: " + message + " <\(className)> \(functionName) [\(lineNumber)] | \(object)")
}
//public func debugLog(object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
//  #if DEBUG
////        let className = (fileName as NSString).lastPathComponent
////        print("<\(className)> \(functionName) [#\(lineNumber)]| \(object)\n")
//  #endif
//    let className = (fileName as NSString).lastPathComponent
//    print("<\(className)> \(functionName) [#\(lineNumber)] | \(object)\n")
//}
public func onTest(value: String) {
    print("Tying to print the value: \(value)")
}


