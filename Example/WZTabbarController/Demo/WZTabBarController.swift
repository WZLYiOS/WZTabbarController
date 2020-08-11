//
//  WZLYTabBarController.swift
//  WZTabBarController
//
//  Created by xiaobin liu on 2019/6/22.
//  Copyright © 2019 xiaobin liu. All rights reserved.
//

import UIKit
import Lottie
import WZTabbarController

/// MARK - 我主良缘Tabbar
final class WZLYTabBarController: WZTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.white
        delegate = self
        configView()
    }
    
    /// 配置视图
    private func configView() {
        
        let v1 = HomeViewController()
        let v2 = MessageViewController()
        let v3 = LiveViewController()
        let v4 = CommunityViewController()
        let v5 = UserViewController()
        
        let n1 = UINavigationController(rootViewController: v1)
        let n2 = UINavigationController(rootViewController: v2)
        let n3 = UINavigationController(rootViewController: v3)
        let n4 = UINavigationController(rootViewController: v4)
        let n5 = UINavigationController(rootViewController: v5)
        
        
        n1.tabBarItem = WZTabBarItem(WZOrdinaryAnimateContentView(resource: "Home"), title: "首页", image: #imageLiteral(resourceName: "tabbar_home"), selectedImage: #imageLiteral(resourceName: "tabbar_home_light_ios"))
        n2.tabBarItem = WZTabBarItem(WZOrdinaryAnimateContentView(resource: "Message"), title: "消息", image: #imageLiteral(resourceName: "mes"), selectedImage: #imageLiteral(resourceName: "mes_light"))
        n3.tabBarItem = WZTabBarItem(WZLoopLottieAnimateContentView(resource: "Live", normalName: "Normal", selectedName: "selected"), title: "视频交友", image: UIImage(), selectedImage: UIImage())
        n4.tabBarItem = WZTabBarItem(WZOrdinaryAnimateContentView(resource: "Community"), title: "社区", image: #imageLiteral(resourceName: "tabbar_dynamic"), selectedImage: #imageLiteral(resourceName: "tabbar_dynamic_light"))
        n5.tabBarItem = WZTabBarItem(WZOrdinaryAnimateContentView(resource: "User"), title: "我的", image: #imageLiteral(resourceName: "person"), selectedImage: #imageLiteral(resourceName: "person_light"))
        
        
        if let tabBarItem = n1.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = "New"
        }
        if let tabBarItem = n2.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = "99+"
        }
        if let tabBarItem = n3.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = "1"
            tabBarItem.badgeColor = UIColor.blue
        }
        if let tabBarItem = n4.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = ""
        }
        if let tabBarItem = n5.tabBarItem as? WZTabBarItem {
            tabBarItem.badgeValue = nil
        }
        
        self.viewControllers = [n1, n2, n3, n4, n5]
    }
}


// MARK: - UITabBarControllerDelegate
extension WZLYTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        /// 判断那个界面需要再次点击刷新。
        if tabBarController.selectedViewController == tabBarController.viewControllers?.first {
            // 判断再次选中的是否为当前控制器
            if viewController == tabBarController.selectedViewController {
                debugPrint("刷新")
                /// 切换tabbaritem 排序的问题
                self.viewControllers = [tabBarController.viewControllers![2],tabBarController.viewControllers![0],tabBarController.viewControllers![1],tabBarController.viewControllers![4],tabBarController.viewControllers![3]]
                return false
            }
        }
        return true
    }
}


/// MARK - 基础tabbaritem内容视图
public class WZBaseTabBarItemContentView: WZTabBarItemContentView {
    
    /// lottie 资源路径
    fileprivate let resource: String
    
    /// 资源包
    fileprivate var bundle: Bundle {
        let bundlePath = Bundle.main.path(forResource: "Tabbar\(resource)", ofType: "bundle")!
        let bundle = Bundle(path: bundlePath)!
        return bundle
    }
    
    /// 初始化
    ///
    /// - Parameter resource: 资源
    init(resource: String) {
        self.resource = resource
        super.init(frame: CGRect.zero)
        renderingMode = .alwaysOriginal
        itemContentMode = .alwaysTemplate
        textColor = UIColor(rgb: 0x1C1C1C)
        highlightTextColor = UIColor(rgb: 0xfb4d38)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// MARK - WZOrdinaryAnimateContentView(普通动画内容视图)
final class WZOrdinaryAnimateContentView: WZBaseTabBarItemContentView {
    
    /// lottieView
    private lazy var lottieView: AnimationView = {
        let view = AnimationView(name: "data", bundle: bundle)
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.isHidden = true
        return view
    }()
    
    
    override init(resource: String) {
        super.init(resource: resource)
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        addSubview(lottieView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lottieView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -6).isActive = true
        lottieView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        lottieView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(animated: animated, completion: nil)
        
        imageView.isHidden = true
        lottieView.isHidden = false
        lottieView.play { [weak self] (completion) in
            guard let self = self else { return }
            self.imageView.isHidden = false
            self.lottieView.isHidden = true
        }
    }
    
    override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(animated: animated, completion: nil)
        lottieView.stop()
        imageView.isHidden = false
        lottieView.isHidden = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// MARK - WZLoopLottieAnimateContentView(循环动画内容视图)
final class WZLoopLottieAnimateContentView: WZBaseTabBarItemContentView {
    
    /// 正常状态名称
    private let normalName: String
    /// 选中状态名称
    private let selectedName: String
    
    /// normalView
    private lazy var normalView: AnimationView = {
        let view = AnimationView(name: normalName, bundle: bundle)
        view.backgroundBehavior = .pauseAndRestore
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.loopMode = .loop
        return view
    }()
    
    /// selectedView
    private lazy var selectedView: AnimationView = {
        let view = AnimationView(name: selectedName, bundle: bundle)
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.loopMode = .playOnce
        view.isHidden = true
        return view
    }()
    
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - resource: 资源名称
    ///   - normalName: 正常状态名称
    ///   - selectedName: 选中状态名称
    init(resource: String, normalName: String, selectedName: String) {
        self.normalName = normalName
        self.selectedName = selectedName
        super.init(resource: resource)
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        
        renderingMode = .alwaysOriginal
        itemContentMode = .alwaysTemplate
        textColor = UIColor(rgb: 0x1C1C1C)
        highlightTextColor = UIColor(rgb: 0xfb4d38)
        
        addSubview(normalView)
        addSubview(selectedView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        normalView.translatesAutoresizingMaskIntoConstraints = false
        normalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        normalView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -6).isActive = true
        normalView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        normalView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectedView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -6).isActive = true
        selectedView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        selectedView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    /// 更新布局
    override func updateLayout() {
        super.updateLayout()
        normalView.play()
    }
    
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(animated: animated, completion: nil)
        normalView.stop()
        normalView.isHidden = true
        selectedView.isHidden = false
        selectedView.play()
    }
    
    override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(animated: animated, completion: nil)
        selectedView.isHidden = true
        selectedView.stop()
        normalView.isHidden = false
        normalView.play()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 颜色16进制转换
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

