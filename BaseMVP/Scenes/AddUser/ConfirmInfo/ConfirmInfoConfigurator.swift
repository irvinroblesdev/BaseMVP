//
//  ConfirmInfoConfigurator.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

class ConfirmInfoConfigurator {
  let user: UserModel
  
  init(user: UserModel) {
    self.user = user
  }
  
  func configure(confirmInfoview: ConfirmInfoViewController) {
    let router = ConfirmInfoRouter(confirmInfoViewController: confirmInfoview)
    let presenter = ConfirmInfoPresenter(view: confirmInfoview, router: router, user: user)
    confirmInfoview.presenter = presenter
  }
}
