//
//  RedirectView.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 3/4/21.
//

import Foundation
import UIKit

class RedirectView {
    private var storyboard: UIStoryboard!
    private var viewController: UIViewController!
    
    public init() {
    }
    public init(storyboardName: String, bundle: Bundle? = nil) {
        let _ = withStoryboard(name: storyboardName, bundle: bundle)
    }
    public init(storyboardName: String, withIdentifier: String, bundle: Bundle? = nil) {
        let _ = withStoryboard(name: storyboardName, bundle: bundle)
        let _ = redirectTo(withIdentifier: withIdentifier)
    }
    public func withStoryboard(name: String, bundle: Bundle? = nil) -> RedirectView {
        storyboard = UIStoryboard(name: name, bundle: bundle)
        return self
    }
    public func redirectTo(withIdentifier: String) -> RedirectView {
        viewController = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        return self
    }
    public func redirectFrom(parentController: UIViewController) -> UIViewController! {
        return redirect(parentController: parentController)
    }
    public func redirect(parentController: UIViewController) -> UIViewController! {
        if storyboard == nil {
            print("Stroyboard is nil")
            return nil
        }
        if viewController == nil {
            print("View controller is nil")
            return nil
        }
        parentController.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
    public func getViewController() -> Any! {
        return viewController
    }
}

/*
let _ = RedirectView()
    .withStoryboard(name: "StoryboardName")
    .redirectTo(withIdentifier: "ViewControllerIdentifier")
    .redirectFrom(parentController: self)
//
//
let _ = RedirectView(storyboardName: "SecondStory", withIdentifier: "ViewControllerIdentifier")
    .redirect(parentController: self)
//
//
let rdirectView = RedirectView(storyboardName: "StoryboardName", withIdentifier: "ViewControllerIdentifier")
let vc = rdirectView.getViewController() as! ViewController
let finalVc = rdirectView.redirect(parentController: self) as! ViewController
*/
extension UIViewController {
    public func redirectView(storyboardName: String, withIdentifier: String, bundle: Bundle? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
}
