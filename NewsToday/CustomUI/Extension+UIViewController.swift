//
//  Extension+UIViewController.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
  func showNormalAlert(for alert: String? = "", completionHandler: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: "OK", style: .cancel) { (alert) in
      completionHandler?()
    }
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
}
