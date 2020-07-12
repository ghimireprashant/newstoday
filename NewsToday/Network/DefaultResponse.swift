//
//  DefaultResponse.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//
import Foundation
import ObjectMapper
import Alamofire
class DefaultResponse: NSObject, NSCoding, Mappable {
  var message: String?
  var code: String?
  var stauts: String?
  required init?(coder aDecoder: NSCoder) {
  }
  override init() {
    super.init()
  }
  func encode(with aCoder: NSCoder) {
  }
  required init?(map: Map) {
  }
  func mapping(map: Map) {
    stauts <- map["status"]
    message <- map["message"]
    code <- map["code"]
  }
}
class DefaultModel: Mappable {
  var id: String?
  var name: String?
  var description: String?
  required init?(map: Map) {
  }
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    description <- map["description"]
    if name == nil {
      name <- map["source.name"]
    }
    if id == nil {
      id <- map["source.id"]
    }
  }
}
