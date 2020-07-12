//
//  NewsContainerDataModel.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import UIKit
struct NewsContainerDataModel {
  var title: NewsCategory
  var viewController = UIStoryboard.newsStoryboard.instantiateNewsViewController()
  init(title: NewsCategory) {
    self.title = title
  }
  static func newsCategory() -> [NewsContainerDataModel] {
    return [NewsContainerDataModel(title: .top), NewsContainerDataModel(title: .business), NewsContainerDataModel(title: .entertainment), NewsContainerDataModel(title: .general), NewsContainerDataModel(title: .health), NewsContainerDataModel(title: .science), NewsContainerDataModel(title: .top), NewsContainerDataModel(title: .technology), NewsContainerDataModel(title: .sports)]
  }
//  static let newsCategory: [NewsCategory] = [.top, .business, .entertainment, .general, .health, .science, .technology, .sports]
}
enum NewsCategory: String {
  case business = "Business"
  case entertainment = "Entertainment"
  case general = "General"
  case health = "Health"
  case science = "Science"
  case technology = "Technology"
  case sports = "Sports"
  case top = "Top"
}
