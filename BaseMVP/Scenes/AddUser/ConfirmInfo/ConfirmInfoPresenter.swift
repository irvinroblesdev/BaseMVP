//
//  ConfirmInfoPresenter.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

protocol ConfirmInfoPresentable: class {
  func confirmUser()
  func viewDidLoad()
}

class ConfirmInfoPresenter: ConfirmInfoPresentable {
  var view: ConfirmInfoViewable
  var router: ConfirmInfoRouter
  var user: UserModel
  
  init(view: ConfirmInfoViewable, router: ConfirmInfoRouter, user: UserModel) {
    self.view = view
    self.router = router
    self.user = user
  }
  
  func viewDidLoad() {
    view.presentUserInfo(user: user)
  }
  
  func confirmUser() {
    
  }
}
