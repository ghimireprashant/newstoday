//
//  Extension+UIImageView.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView {
  func setURLImage(imageURL: String?, placeHolder defaultImage: String = "iconPlaceholder") {
    //    SDImageCache.shared().clearMemory()
    if let image = imageURL, image != "" {
        self.sd_imageTransition = .fade
        let properURL = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: properURL ?? "")
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let placeHolderImage = UIImage(named: defaultImage)
        self.sd_setImage(with: url, placeholderImage: placeHolderImage)
    } else {
      self.image = UIImage(named: "iconPlaceholder")
    }
  }
}
