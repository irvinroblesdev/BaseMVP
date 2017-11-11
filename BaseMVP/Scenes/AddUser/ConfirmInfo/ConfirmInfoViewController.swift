//
//  ConfirmInfoViewController.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import UIKit

protocol ConfirmInfoViewable {
  func presentUserInfo(user: UserModel)
  func dismissLoader()
}

class ConfirmInfoViewController: UIViewController {
  var configurator: ConfirmInfoConfigurator?
  weak var presenter: ConfirmInfoPresentable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator?.configure(confirmInfoview: self)
    presenter?.viewDidLoad()
  }
}

extension ConfirmInfoViewController: ConfirmInfoViewable {
  func dismissLoader() {
  }
  
  func presentUserInfo(user: UserModel) {
  }
}
