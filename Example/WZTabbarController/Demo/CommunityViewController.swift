//
//  CommunityViewController.swift
//  WZTabBarController
//
//  Created by xiaobin liu on 2019/6/22.
//  Copyright © 2019 xiaobin liu. All rights reserved.
//  CommunityViewController

import UIKit
import Lottie
import WZTabbarController

class CommunityViewController: UIViewController {

    /// <#type name#>
    private lazy var lottieView: AnimationView = {
        $0.loopMode = .loop
        $0.play()
        return $0
    }(AnimationView(name: "data"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if let tabBarItem = navigationController?.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = ""
        }
        configView()
        configViewLocation()
    }
    
    /// 添加视图
    private func configView() {
        view.addSubview(lottieView)
    }
    
    /// 视图位置
    private func configViewLocation() {
        lottieView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
}
