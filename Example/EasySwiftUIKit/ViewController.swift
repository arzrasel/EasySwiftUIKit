//
//  ViewController.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 01/16/2021.
//  Copyright (c) 2021 Rz Rasel. All rights reserved.
//

import UIKit
import EasySwiftUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        onTest(value: "hi")
        FileUtils.JSON.readFileUsage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
struct testEasySwiftUIKit {
    var data: QuantumValue!
}
