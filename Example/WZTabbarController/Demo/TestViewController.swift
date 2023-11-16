//
//  TestViewController.swift
//  WZTabbarController_Example
//
//  Created by qiuqixiang on 2021/4/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let tabbar = UIApplication.shared.keyWindow?.rootViewController as? WZLYTabBarController else {
            return
        }
        self.navigationController?.popToRootViewController(animated: false)
        tabbar.selectedIndex = 2
    }

}
