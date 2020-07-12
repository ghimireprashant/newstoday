//
//  Storyboard+News.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {
  private struct Constants {
    static let newsStoryboard = "News"
    static let newsIdentifier = "NewsViewController"
    static let newsContainer = "NewsContainerViewController"
    static let newsSourceIdentifier = "SourcesViewController"
  }
  static var newsStoryboard: UIStoryboard {
    return UIStoryboard(name: Constants.newsStoryboard, bundle: nil)
  }
  func instantiateNewsViewController() -> NewsViewController {
    guard let viewController = UIStoryboard.newsStoryboard.instantiateViewController(withIdentifier: Constants.newsIdentifier) as? NewsViewController else {
      fatalError("Couldn't instantiate NewsViewController")
    }
//    viewController.newsType = newsType
    return viewController
  }
  func instantiateNewsContainerViewController() -> NewsContainerViewController {
    guard let viewController = UIStoryboard.newsStoryboard.instantiateViewController(withIdentifier: Constants.newsContainer) as? NewsContainerViewController else {
      fatalError("Couldn't instantiate NewsContainerViewController")
    }
    return viewController
  }
  func instantiateSourcesViewController(category: String?) -> SourcesViewController {
    guard let viewController = UIStoryboard.newsStoryboard.instantiateViewController(withIdentifier: Constants.newsSourceIdentifier) as? SourcesViewController else {
      fatalError("Couldn't instantiate NewsContainerViewController")
    }
    viewController.category = category
    return viewController
  }
}
