//
//  PGDeviceDetector.swift
//
//  Created by Prashant Ghimire on 10/3/17.
//  Copyright © 2017 prashant.ghimire@gmail.com. All rights reserved.
//

import Foundation
import  UIKit

struct ScreenSize {
  static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
  static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
  static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
  static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceDetector {
  static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
  static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
  static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
  static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
  static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
  static let IS_IPHONE_7          = IS_IPHONE_6
  static let IS_IPHONE_7P         = IS_IPHONE_6P
  static let IS_IPHONE_XS_MAX     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
//  static let IS_IPHONE_11         = IS_IPHONE_6P
  static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
}
