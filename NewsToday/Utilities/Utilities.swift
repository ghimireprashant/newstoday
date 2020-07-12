//
//  Utilities.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//

import Foundation
class Utilities: NSObject {
  class func getRegion() -> String {
    if let regionCode = Locale.current.regionCode?.lowercased(), Constants.supportedCountry.contains(regionCode) {
      return regionCode
    }
    return "us"
  }
 class func getLanguage() -> String {
    if let regionCode = Locale.preferredLanguages[0].strstr(needle: "-", beforeNeedle: true), Constants.supportedLanguage.contains(regionCode) {
      return regionCode
    }
    return "en"
  }
}
extension String {
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        return self.substring(from: range.upperBound)
    }
  func validateUrl () -> Bool {
      let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
      return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
  }
  func convertDate(format: String = "yyyy-MM-dd", enableLocal: Bool? = false) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    if enableLocal ?? false {
      dateFormatter.locale = NSLocale.system
    }
    return dateFormatter.date(from: self) ?? Date()
  }
}
extension Date {
  func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a", enableLocal: Bool? = false) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    if enableLocal ?? false {
      dateFormatter.locale = NSLocale.system
    }
    return dateFormatter.string(from: self)
  }
}
