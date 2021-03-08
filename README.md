# EasySwiftUIKit

[![Rz Rasel](https://raw.githubusercontent.com/arzrasel/svg/main/rz-rasel-blue.svg)](https://github.com/rzrasel)
[![CI Status](https://img.shields.io/travis/Rashed/EasySwiftUIKit.svg?style=flat)](https://travis-ci.org/Rashed/EasySwiftUIKit)
[![Version](https://img.shields.io/cocoapods/v/EasySwiftUIKit.svg?style=flat)](https://cocoapods.org/pods/EasySwiftUIKit)
[![License](https://img.shields.io/cocoapods/l/EasySwiftUIKit.svg?style=flat)](https://cocoapods.org/pods/EasySwiftUIKit)
[![Platform](https://img.shields.io/cocoapods/p/EasySwiftUIKit.svg?style=flat)](https://cocoapods.org/pods/EasySwiftUIKit)
[![GitHub release](https://img.shields.io/github/tag/arzrasel/EasySwiftUIKit.svg)](https://github.com/arzrasel/EasySwiftUIKit/releases)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11
- Swift 5
- Xcode 12

## Installation

EasySwiftUIKit is available through [CocoaPods](https://cocoapods.org/pods/EasySwiftUIKit). To install
it, simply add the following line to your Podfile:

```podInstallEasySwiftUIKit01
pod 'EasySwiftUIKit'
```
or
```podInstallEasySwiftUIKit02
pod 'EasySwiftUIKit', '~> 1.0'
```

### Integration In Project

```IntegrationInProject
import EasySwiftUIKit
```

### Date Format in Swift

```DateFormatInSwiftOne
//stringDate.dateFormat(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
//Return formatted date in string form
let date = "2021-03-28 12:24:26".dateFormat(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
```
or
```DateFormatInSwiftTwo
//stringDate.dateToString(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
//Return formatted date in string form
let date = "2021-02-28 12:24:26".dateToString(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
```
or
```DateFormatInSwiftThree
//stringDate.dateToDate(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
//Return formatted date in date form
let date = "2021-02-28 12:24:26".dateToDate(toFormat: "yyyy-MM-dd HH:mm:ss", withFormat: "MMM dd,yyyy")
```

### Parse JSON

```JSONParseWay001
let jsonResult = JSONParser.parseJSON(dataModel: [DataModel].self, jsonData: response)
switch jsonResult {
case .success(let result):
    for item in result {
    }
case .failure(let error):
    print("Error: \(error)")
}
```

### Quantum Value: Decode string or int value in structure

```DecodeQuantumValue
//struct data model
struct ModelData: Decodable {
    var name: String!
    var data: QuantumValue!
}

//individual/single data model
let modelData = ModelData(name: "Rz Rasel", data: QuantumValue.string("Rashed - Uz - Zaman"))

//List of data model
let modelDataList = [
    ModelData(name: "Rz Rasel", data: QuantumValue.int(1)),
    ModelData(name: "Rz Rasel", data: QuantumValue.string("Rashed - Uz - Zaman"))
]

//Usages of list of data model
let strValue = modelData.data.stringValue

//Usages of individual/single data model
for item in modelDataList {
    let name = item.name
    let intVal = item.data.intValue
    let strVal = item.data.stringValue
    let safeIntVal = item.data?.intValue
    let safeStrVal = item.data?.stringValue
}
```

## Author

Md. Rashed - Uz - Zaman (Rz Rasel)

## License

EasySwiftUIKit is available under the MIT license. See the LICENSE file for more info.

<!--https://github.com/goktugyil/EZSwiftExtensions-->
