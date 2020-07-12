//
//  Extension+UIView.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
extension UIView {
  @IBInspectable
  var viewCornerRadious: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
}
