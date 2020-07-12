//
//  CustomNavigationController.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
class CustomNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.isTranslucent = false
    self.navigationBar.tintColor = UIColor.white
    self.navigationBar.barTintColor = UIColor.appThemeColor
    self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    self.navigationBar.backIndicatorTransitionMaskImage = UIImage()
  }
}
