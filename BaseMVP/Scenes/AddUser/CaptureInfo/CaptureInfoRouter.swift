//
//  AddUserRouter.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation
import UIKit

enum CaptureInfoNavigationOptions {
  case confirmView
  case returnView
}

class CaptureInfoRouter {
  typealias constants = AddUserConstants
  weak var captureInfoViewController: CaptureInfoViewController?
  
  init(captureInfoViewController: CaptureInfoViewController) {
    self.captureInfoViewController = captureInfoViewController
  }
  
  func navigateTo(viewOpton: CaptureInfoNavigationOptions, data: Any?) {
    switch viewOpton {
    case .confirmView:
      if let user = data as? UserModel, let confirmView = UIStoryboard(name: constants.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: constants.confirmInfoViewName) as? ConfirmInfoViewController {
        confirmView.configurator = ConfirmInfoConfigurator(user: user)
        captureInfoViewController?.navigationController?.pushViewController(confirmView, animated: true)
      }
    case .returnView:
      captureInfoViewController?.navigationController?.popViewController(animated: true)
    }
  }
}
