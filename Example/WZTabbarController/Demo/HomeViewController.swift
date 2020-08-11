//
//  HomeViewController.swift
//  WZTabBarController
//
//  Created by xiaobin liu on 2019/6/22.
//  Copyright © 2019 xiaobin liu. All rights reserved.
//

import UIKit
import Lottie
import EasyRefresher
import WZTabbarController

class HomeViewController: UIViewController {
        
    /// feed视图
    private lazy var feedLoadingView: AnimationView = {
        let view = AnimationView(name: "profile")
        view.backgroundBehavior = .pauseAndRestore
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// 列表
    private lazy var tableView: UITableView = {
        $0.rowHeight = 50
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        $0.tableFooterView = UIView()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .singleLineEtched
        $0.isHidden = true
        $0.dataSource = self
        $0.refresh.footer = RefreshFooter(stateView: HomeFooterRefresh(), height: 90, refreshClosure: { [weak self] in
            guard let self = self else { return }
            self.reloadMore()
        })
        return $0
    }(UITableView())
    
    /// 数组
    private var array: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(feedLoadingView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            feedLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedLoadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedLoadingView.widthAnchor.constraint(equalToConstant: 300),
            feedLoadingView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        reloadData()
    }
    
    /// 加载数据
    private func reloadData() {
        feedLoadingView.play()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.feedLoadingView.stop()
            self.array = (1...20).map { $0 }
            self.feedLoadingView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    /// 加载更多数据
    @objc
    private func reloadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.array.append(contentsOf: (self.array.count...(self.array.count + 10)).map { $0 })
            self.tableView.reloadData()
            self.tableView.refresh.footer.endRefreshing()
        }
    }
}

/// MARK - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
