# 我主良缘WZTabbarController

## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'WZTabbarController', '~> 1.0.0'</code></pre>

## Use

```swift

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
```

## Reference
<ul>
<li><a href="https://github.com/eggswift/ESTabBarController"><code>ESTabBarController</code></a></li>
</ul>

## License
WZTabbarController is released under an MIT license. See [LICENSE](LICENSE) for more information.
