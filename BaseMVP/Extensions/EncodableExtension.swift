//
//  EncodableExtension.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/17/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation
extension Encodable {
  var dictionary: [String: Any] {
    do {
      if let dict = try JSONSerialization.jsonObject(with: JSONEncoder().encode(self)) as? [String: Any] {
        return dict
      } else {
        return [:]
      }
    } catch {
      return [:]
    }
  }
}
