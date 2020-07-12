//
//  ApiManager.swift
//  NewsToday
//
//  Created by Prashant Ghimire on 6/6/20.
//  Copyright © 2020 Prashant Ghimire. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SVProgressHUD

public class APIManager {
  var request: DataRequest!
  public init (urlString: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, addLocation: Bool = true, method: Alamofire.HTTPMethod = .post, encoding: ParameterEncoding = URLEncoding.default) {
    var headers = headers, parameters = parameters
//    if let token = UserDefaultsHandler.getUDValue(key: UDkey.token) as? String {
//      if headers == nil {
//        headers = ["Authorization": "Bearer \(token)", "Content-Type": "application/json", "clientid": "20190921396595126990172019", "clientsecret": "89471ba483dfaf5cc86650f929c37db4499066"]
//      } else {
//        headers!["Authorization"] = "Bearer \(token)"
//        headers!["Content-Type"] = "application/json"
//        headers!["clientid"] = "20190921396595126990172019"
//        headers!["clientsecret"] = "89471ba483dfaf5cc86650f929c37db4499066"
//      }
    if parameters == nil {
      parameters = ["apiKey": Constants.apiKey, "country": Utilities.getRegion(), "language": Utilities.getLanguage()]
    } else {
      if parameters!["sources"] == nil {
        parameters!["country"] = Utilities.getRegion()
      }
      parameters!["apiKey"] = Constants.apiKey
      parameters!["language"] = Utilities.getLanguage()
    }
//    }
  debugPrint(headers, parameters, urlString, method)
    self.request = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters ?? nil, encoding: encoding, headers: headers ?? nil)
  }
  func handleResponse<T: DefaultResponse>(showProgressHud: Bool = true, showBanner: Bool = false, completionHandler: @escaping (T) -> Void, failureBlock: @escaping (() -> Void)) {
     let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let mainWindow = (windowScene?.delegate as? SceneDelegate)?.window
    guard NetworkReachabilityManager()!.isReachable else {
      failureBlock()
      let alertController = UIAlertController(title: "No Internet Connection", message: "Please enable data / wifi from settting", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(cancelAction)
      mainWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
      failureBlock()
      return
    }
    if showProgressHud && SVProgressHUD.isVisible() == false {
      ProgressHud.showProgressHUD()
    }
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 900 // seconds
    configuration.timeoutIntervalForResource = 900
    _ = Alamofire.SessionManager(configuration: configuration)
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    self.request.responseObject {(response: DataResponse<T>) in
      ProgressHud.hideProgressHUD()
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch response.result {
      case .success(let dataX):
        if showBanner {
//          appDelegate?.window?.rootViewController?.showBanner(title: dataX.message ?? "", isError: response.response?.statusCode == 200 ? false:true)
        }
        if 200...204 ~= response.response?.statusCode ?? 0 {
          completionHandler(dataX)
        } else {
          mainWindow?.rootViewController?.showNormalAlert(for: dataX.message)
          failureBlock()
        }
      case .failure(let error):
        mainWindow?.rootViewController?.showNormalAlert(for: "Unable to connect to server")
        print(error)
      }
    }
    //delete
    self.request.responseJSON {(response) in
      print(response.result.value ?? "No Value")
      print(response.result )
      print(response.error ?? "")
      print(response.response ?? "")
      print(response.request ?? "No request")
      switch response.result {
      case .failure(let error):
        print(error)
      case .success(let val):
        print(val)
      }
    }
  }
}
class ProgressHud: NSObject {
  class func showProgressHUD() {
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
    SVProgressHUD.setForegroundColor(UIColor.white)
    SVProgressHUD.setBackgroundColor(UIColor.clear)
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    SVProgressHUD.setRingNoTextRadius(20)
    SVProgressHUD.setRingThickness(3)
    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
  }
  class func hideProgressHUD() {
    SVProgressHUD.dismiss()
  }
  class func showSuccessWithMessage(message: String?) {
    SVProgressHUD.showSuccess(withStatus: message)
    SVProgressHUD.setBackgroundColor(UIColor.blue)
    SVProgressHUD.dismiss(withDelay: 4)
  }
  class func showInfoWithMessage(message: String?) {
    SVProgressHUD.showInfo(withStatus: message)
    SVProgressHUD.setBackgroundColor(UIColor.green)
    SVProgressHUD.dismiss(withDelay: 4)
  }
}
