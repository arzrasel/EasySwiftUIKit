//
//  Contents.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-03
//EasySwiftUIKit Version (UIViewController->alert implementation and integration at) - 1.0.3
//

import Foundation
import UIKit

public extension UIViewController {
    func alert(title: String = "", message: String, actionTitle:String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func usageAlert() {
//        "class TestVC: UIViewController {
//            override func viewDidAppear(animated: Bool) {
//                super.viewDidAppear(animated)
//
//                self.alert("Hello", message: "This is a sample alert controller", actionTitle: "Dismiss")
//            }
//        }"
    }
}
//
public extension String {
    func toAttributedString(font: UIFont!, kerning: CGFloat!, color: UIColor!) -> NSAttributedString {
        return NSAttributedString(string: self as String, font: font, kerning: kerning, color: color)!
    }
}

public extension NSAttributedString {
    convenience init?(string text: String, font: UIFont!, kerning: CGFloat!, color: UIColor!) {
        self.init(string: text, attributes: [NSAttributedString.Key.kern: kerning!, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: color!])
    }
}
//// Example Usage
//var testString: String = "Hello World"
//
//var testAttributedString: NSAttributedString = testString.toAttributedString(font: UIFont.boldSystemFontOfSize(20), kerning: 2.0, color: UIColor.whiteColor())
//
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 20))
//
//label.attributedText = testAttributedString
//view.addSubview(label)
//
