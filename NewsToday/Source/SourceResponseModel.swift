//
//  SourceResponseModel.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
class SourceResponseModel: DefaultResponse {
  var sources: [SourceModel]?
  override func mapping(map: Map) {
    super.mapping(map: map)
    sources <- map["sources"]
  }
  class func requestForTopNewsSource(category: String? = nil, completionHandel: @escaping (SourceResponseModel?) -> Void) {
    APIManager(urlString: AppURL.newsSource, parameters: ["category": category ?? ""], method: .get, encoding: URLEncoding.default).handleResponse(showProgressHud: true, showBanner: true, completionHandler: { (response: SourceResponseModel) in
        completionHandel(response)
      }, failureBlock: {
      })
    }
}
class SourceModel: DefaultModel {
  var url: String?
  var category: String?
  override func mapping(map: Map) {
    super.mapping(map: map)
    self.url <- map["url"]
    self.category <- map["category"]
  }
}
