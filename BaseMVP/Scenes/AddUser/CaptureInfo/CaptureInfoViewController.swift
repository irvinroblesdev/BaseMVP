//
//  AddUserViewController.swift
//  BaseMVP
//
//  Created by Irvin Robles on 11/5/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import UIKit

protocol CaptureInfoViewable {
  func dismissLoader()
}

class CaptureInfoViewController: UIViewController {
  let configurator = CaptureInfoConfigurator()
  weak var presenter: CaptureInfoPresentable?
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }
}
extension CaptureInfoViewController: CaptureInfoViewable {
  func dismissLoader() {
    
  }
}
