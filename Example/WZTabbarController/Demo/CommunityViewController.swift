//
//  CommunityViewController.swift
//  WZTabBarController
//
//  Created by xiaobin liu on 2019/6/22.
//  Copyright © 2019 xiaobin liu. All rights reserved.
//  CommunityViewController

import UIKit
import WZTabbarController

class CommunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if let tabBarItem = navigationController?.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = ""
        }
    }
}
