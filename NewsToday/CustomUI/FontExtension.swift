//
//  FontExtension.swift
//  ServiceIdol
//
//  Created by Prashant Ghimire on 4/2/19.
//  Copyright © 2019 prashantghimire@gmail.com. All rights reserved.
//

import Foundation
import UIKit
enum FontType: Int {
  case body = 0, title = 1, date = 2, author = 3, source = 4
  var customFont: UIFont {
    switch self {
    case .body :
      if DeviceDetector.IS_IPHONE_4_OR_LESS {
        return UIFont.systemFont(ofSize: 10)
      } else if DeviceDetector.IS_IPHONE_5 {
        return UIFont.systemFont(ofSize: 11)
      } else if DeviceDetector.IS_IPHONE_6 {
        return UIFont.systemFont(ofSize: 12)
      } else if DeviceDetector.IS_IPHONE_6P {
        return UIFont.systemFont(ofSize: 14)
      } else if DeviceDetector.IS_IPHONE_X {
        return UIFont.systemFont(ofSize: 16)
      } else if DeviceDetector.IS_IPHONE_XS_MAX {
        return UIFont.systemFont(ofSize: 18)
      } else {
        return UIFont.systemFont(ofSize: 12)
      }
    case .title:
      if DeviceDetector.IS_IPHONE_4_OR_LESS {
        return UIFont.systemFont(ofSize: 13, weight: .semibold)
      } else if DeviceDetector.IS_IPHONE_5 {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
      } else if DeviceDetector.IS_IPHONE_6 {
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
      } else if DeviceDetector.IS_IPHONE_6P {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
      } else if DeviceDetector.IS_IPHONE_X {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
      } else if DeviceDetector.IS_IPHONE_XS_MAX {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
      } else {
        return UIFont.systemFont(ofSize: 13, weight: .semibold)
      }
    case .date:
      if DeviceDetector.IS_IPHONE_4_OR_LESS {
        return UIFont.systemFont(ofSize: 10)
      } else if DeviceDetector.IS_IPHONE_5 {
        return UIFont.systemFont(ofSize: 11)
      } else if DeviceDetector.IS_IPHONE_6 {
        return UIFont.systemFont(ofSize: 12)
      } else if DeviceDetector.IS_IPHONE_6P {
        return UIFont.systemFont(ofSize: 14)
      } else if DeviceDetector.IS_IPHONE_X {
        return UIFont.systemFont(ofSize: 16)
      } else if DeviceDetector.IS_IPHONE_XS_MAX {
        return UIFont.systemFont(ofSize: 18)
      } else {
        return UIFont.systemFont(ofSize: 12)
      }
    case .author:
      if DeviceDetector.IS_IPHONE_4_OR_LESS {
        return UIFont.systemFont(ofSize: 10)
      } else if DeviceDetector.IS_IPHONE_5 {
        return UIFont.systemFont(ofSize: 11)
      } else if DeviceDetector.IS_IPHONE_6 {
        return UIFont.systemFont(ofSize: 12)
      } else if DeviceDetector.IS_IPHONE_6P {
        return UIFont.systemFont(ofSize: 14)
      } else if DeviceDetector.IS_IPHONE_X {
        return UIFont.systemFont(ofSize: 16)
      } else if DeviceDetector.IS_IPHONE_XS_MAX {
        return UIFont.systemFont(ofSize: 18)
      } else {
        return UIFont.systemFont(ofSize: 12)
      }
    case .source:
      if DeviceDetector.IS_IPHONE_4_OR_LESS {
        return UIFont.systemFont(ofSize: 12)
      } else if DeviceDetector.IS_IPHONE_5 {
        return UIFont.systemFont(ofSize: 13)
      } else if DeviceDetector.IS_IPHONE_6 {
        return UIFont.systemFont(ofSize: 14)
      } else if DeviceDetector.IS_IPHONE_6P {
        return UIFont.systemFont(ofSize: 15)
      } else if DeviceDetector.IS_IPHONE_X {
        return UIFont.systemFont(ofSize: 16)
      } else if DeviceDetector.IS_IPHONE_XS_MAX {
        return UIFont.systemFont(ofSize: 18)
      } else {
        return UIFont.systemFont(ofSize: 12)
      }
    }
  }
  static func getFont(rawValue: Int) -> UIFont {
    if let fontType = FontType(rawValue: rawValue) {
      return fontType.customFont
    }
    return FontType.body.customFont
  }
}
extension UILabel {
  @IBInspectable var textFont: Int {
    set {
      self.font = FontType.getFont(rawValue: newValue)
    }
    get {
      return 0
    }
  }
}
extension UIButton {
  @IBInspectable var textFont: Int {
    set {
      self.titleLabel!.font = FontType.getFont(rawValue: newValue)
    }
    get {
      return 0
    }
  }
}
