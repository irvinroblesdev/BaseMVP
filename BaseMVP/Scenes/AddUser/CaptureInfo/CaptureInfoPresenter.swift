//
//  AddUserPresenter.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

protocol CaptureInfoPresentable: class {
  func addUser()
}

class CaptureInfoPresenter: CaptureInfoPresentable {
  var view: CaptureInfoViewable
  var router: CaptureInfoRouter
  
  init(view: CaptureInfoViewable, router: CaptureInfoRouter) {
    self.view = view
    self.router = router
  }
  
  func addUser() {
    
  }
}
