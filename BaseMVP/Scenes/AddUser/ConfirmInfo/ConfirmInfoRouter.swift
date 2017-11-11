//
//  ConfirmInfoRouter.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

enum ConfirmInfoNavigationOptions {
  case operationResult
  case returnView
}

class ConfirmInfoRouter {
  var confirmInfoViewController: ConfirmInfoViewController?
  
  init(confirmInfoViewController: ConfirmInfoViewController) {
    self.confirmInfoViewController = confirmInfoViewController
  }
  
  func navigateTo(viewOpton: ConfirmInfoNavigationOptions, withData: NSObject?) {
    switch viewOpton {
    case .operationResult:
      break
    case .returnView:
      confirmInfoViewController?.navigationController?.popViewController(animated: true)
    }
  }
}
