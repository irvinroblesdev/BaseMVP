//
//  AddUserConfigurator.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

class CaptureInfoConfigurator {
  func configure(captureInfoview: CaptureInfoViewController) {
    let router = CaptureInfoRouter(captureInfoViewController: captureInfoview)
    let presenter = CaptureInfoPresenter(view: captureInfoview, router: router)
    captureInfoview.presenter = presenter
  }
}
