//
//  HomeFooterRefresh.swift
//  WZTabbarController_Example
//
//  Created by xiaobin liu on 2020/5/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Lottie
import EasyRefresher


/// MARK - 自定义首页底部刷新
final class HomeFooterRefresh: UIView {
    
    /// feed视图
    private lazy var feedLoadingView: AnimationView = {
        let view = AnimationView(name: "feed")
        view.backgroundBehavior = .pauseAndRestore
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// 消息标签
    private lazy var messageLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = UIColor.red
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    init() {
        super.init(frame: .zero)
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        addSubview(messageLabel)
        addSubview(feedLoadingView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            feedLoadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedLoadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedLoadingView.widthAnchor.constraint(equalToConstant: 200),
            feedLoadingView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// MARK - RefreshStateful
extension HomeFooterRefresh: RefreshStateful {
    
    public func refresher(_ refresher: Refresher, didChangeState state: RefreshState) {
        switch state {
        case .idle:
            break
        case .pulling:
            messageLabel.isHidden = false
            messageLabel.text = "上拉加载更多"
            feedLoadingView.isHidden = true
            feedLoadingView.stop()
        case .willRefresh:
            messageLabel.isHidden = false
            messageLabel.text = "松手开始加载"
            feedLoadingView.isHidden = true
            feedLoadingView.stop()
        case .refreshing:
            messageLabel.text = "加载中..."
            messageLabel.isHidden = true
            feedLoadingView.isHidden = false
            feedLoadingView.play()
        case .disabled:
            break
        }
    }
    
    public func refresher(_ refresher: Refresher, didChangeOffset offset: CGFloat) {
        debugPrint(offset/refresher.height)
    }
}
