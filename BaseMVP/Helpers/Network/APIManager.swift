//
//  APIManager.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/16/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import UIKit
import Alamofire

class APIManager {
  private let host = NetworkConfiguration.staticConf["API_HOST"] as! String
  static let shared = APIManager()
  private init() {}
  
  lazy var sessionManager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForResource = NetworkConfiguration.timeOutInterval
    return SessionManager(configuration: configuration)
  }()
  
  private func getHeaders() -> HTTPHeaders {
    let token = "" //Call keychain method to get the token
    let headers: HTTPHeaders = [
      "Authorization": token
    ]
    return headers
  }
  
  private func getAPIUrl(url: APIUrl) -> String {
    guard let apiUrl = NetworkConfiguration.staticURL[url] as? String else { return "" }
    return apiUrl
  }
  
  func loginRequest<T: ResponseProtocol>(DTO: Codable, validStatusCodes: [Int], onSuccess: @escaping ((T) -> Void), onError: @escaping ((ErrorResponse) -> Void)) {
    let completeURL = "\(host)\(getAPIUrl(url: .loginUrl))"
    sessionManager.request(completeURL,
                           method: .post,
                           parameters: DTO.dictionary,
                           encoding: JSONEncoding.default,
                           headers: nil)
      .validate(statusCode: validStatusCodes)
      .responseData(completionHandler: { data in
        guard let status = data.response?.statusCode else { return }
        switch (data.result) {
        case .success(let value):
          do {
            let parsedResponse = try JSONDecoder().decode(T.self, from: value)
            
            onSuccess(parsedResponse)
          }
          catch {
            onError(ErrorResponse(statusCode: .parsingError, message: "Error al parsear la respuesta del servicio"))
          }
        case .failure:
          onError(ErrorResponse(statusCode: ResponseError(rawValue: status), message: "Error"))
        }
      }
    )
  }
  
  func request<T: ResponseProtocol>(url: APIUrl, method: HTTPMethod, requestDTO: RequestProtocol, responseDTO: T, encoding: ParameterEncoding = JSONEncoding.default, headers: Bool, validStatusCodes: [Int] = NetworkConfiguration.validStatusCodes, onSuccess: @escaping ((T) -> Void), onError: @escaping ((ErrorResponse) -> Void)) {
    let completeURL = "\(host)\(getAPIUrl(url: url))"
    sessionManager.request(completeURL,
                           method: method,
                           parameters: requestDTO.dictionary,
                           encoding: encoding,
                           headers: headers ? getHeaders() : nil)
      .validate(statusCode: validStatusCodes)
      .responseData(completionHandler: { data in
        guard let status = data.response?.statusCode else { return }
        switch (data.result) {
        case .success(let value):
          do {
            let parsedResponse = try JSONDecoder().decode(T.self, from: value)
            onSuccess(parsedResponse)
          }
          catch {
            onError(ErrorResponse(statusCode: .parsingError, message: "Error al parsear la respuesta del servicio"))
          }
        case .failure:
          onError(ErrorResponse(statusCode: ResponseError(rawValue: status), message: "Error"))
        }
      }
    )
  }
}
