//
//  Movie.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/17/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

struct Movie: RequestProtocol {
  enum MovieGenere: String, Codable {
    case horror, skifi, comedy, adventure, animation
  }
  
  var name : String
  var moviesGenere : [MovieGenere]
  var rating : Int
}
