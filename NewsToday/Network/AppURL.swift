//
//  AppURL.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
class AppURL: NSObject {
  //http://202.51.74.69:8085
  static let localURL = ""
  static let liveURL = "https://newsapi.org/"
  static let debugURL = ""
  static let baseURL = liveURL
  static let apiVersion = "v2/"

  static var topNews: String = {
    let url = AppURL.baseURL + AppURL.apiVersion + "top-headlines"
    return url
  }()
  static var newsSource: String = {
    let url = AppURL.baseURL + AppURL.apiVersion + "sources"
    return url
  }()
}
