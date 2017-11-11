//
//  NetworkConfiguration.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/16/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation
struct NetworkConfiguration {
  static let timeOutInterval = 30.0
  static let validStatusCodes = [200]
  static var staticConf: NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)!
  static var staticURL: NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "APIUrls", ofType: "plist")!)!
}

enum ResponseError: Int {
  case serverNotAvailable = 500
  case unAuthorized = 401
  case parsingError = 600
}

enum APIUrl: String {
  case loginUrl
  case getInfo
}
