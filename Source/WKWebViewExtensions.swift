//
//  WKWebViewExtensions.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-28
//

import Foundation
import WebKit

extension WKWebView {
    public func load(_ urlString: String) {
        load(url: urlString)
    }
    public func load(url urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        } else {
            print("URL not valid: " + urlString)
        }
    }
    public func loadHTML(forResource resourceString: String, withExtension extensionString: String = "html") {
        if let url = Bundle.main.url(forResource: resourceString, withExtension: extensionString) {
            loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    public func loadHTML(htmlString: String) {
        loadHTMLString(htmlString, baseURL: Bundle.main.resourceURL)
    }
}
public func getWebViewUrl(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) -> String! {
    var urlStr: String! = nil
    if let data = navigationAction.request.url?.absoluteString {
        //urlStr is what you want
//        print("=========decidePolicyFor: \(urlStr)")
        urlStr = data
    }
    decisionHandler(.allow)
    return urlStr
}
