//
//  NewsResponseModel.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
class NewsResponseModel: DefaultResponse {
  var news: [TopNewsModel]?
  override func mapping(map: Map) {
    super.mapping(map: map)
    news <- map["articles"]
  }
  class func requestForTopNews(page: Int, newsSource: String? = nil, newsCategory: String? = nil, showHud: Bool, completionHandel: @escaping (NewsResponseModel?) -> Void) {
    var params: [String: Any] = [:]
    if let type = newsSource {
      params["sources"] = type
    }
    if let category = newsCategory {
      params["category"] = category
    }
    params["page"] = page
    params["pageSize"] = 20
    APIManager(urlString: AppURL.topNews, parameters: params, method: .get, encoding: URLEncoding.default).handleResponse(showProgressHud: showHud, showBanner: true, completionHandler: { (response: NewsResponseModel) in
        completionHandel(response)
      }, failureBlock: {
      })
    }
}
class TopNewsModel: DefaultModel {
  var author: String?
  var title: String?
  var contentSource: String?
  var imageURL: String?
  var date: String?
  var content: String?
  override func mapping(map: Map) {
    super.mapping(map: map)
    author <- map["author"]
    title <- map["title"]
    contentSource <- map["url"]
    imageURL <- map["urlToImage"]
    date <- map["publishedAt"]
    content <- map["content"]
    date = date?.convertDate(format: "yyyy-MM-dd'T'HH:mm:ssZ", enableLocal: false).dateString("dd MMMM yyyy ● hh:mm:ss a", enableLocal: false)
  }
}
