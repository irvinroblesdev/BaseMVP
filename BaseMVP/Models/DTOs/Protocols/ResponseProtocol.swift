//
//  BaseResponseProtocol.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/17/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

protocol ResponseProtocol: Codable {
  var statusCode: Int { get set }
  var message: String { get set }
}
