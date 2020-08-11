//
//  UserViewController.swift
//  WZTabBarController
//
//  Created by xiaobin liu on 2019/6/22.
//  Copyright © 2019 xiaobin liu. All rights reserved.
//

import UIKit
import EasyRefresher
import RPCircularProgress

/// MARK - 个人中心控制器
final class UserViewController: UIViewController {
    
    /// 列表
    private lazy var tableView: UITableView = {
        $0.rowHeight = 50
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        $0.tableFooterView = UIView()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .singleLineEtched
        $0.dataSource = self
        
        
        $0.refresh.footer = AppearanceRefreshFooter(stateView: UserProgressView(), height: 90, refreshClosure: { [weak self] in
            guard let self = self else { return }
            self.tableView.beginUpdates()
            
            var indexPaths: [IndexPath] = []
            for (index, _) in self.array.enumerated() {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
            self.tableView.deleteRows(at: indexPaths, with: UITableView.RowAnimation.top)
            self.array.removeAll()
            self.tableView.endUpdates()
            self.tableView.refresh.footer.endRefreshing()
        })
        return $0
    }(UITableView())
    
    private lazy var array = (0...20).map { "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    /// 加载更多数据
    @objc
    private func reloadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.tableView.reloadData()
            self.tableView.refresh.footer.endRefreshing()
        }
    }
}

/// MARK - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}



/// MARK - UserProgressView
final class UserProgressView: UIView {
    
    /// 消息标签
    private lazy var messageLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = UIColor.red
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "继续上滑探索更多精彩"
        return $0
    }(UILabel())
    
    
    /// 这边没有图标暂时先用这个标签
    private lazy var iconLabel: UILabel = {
        $0.textColor = UIColor.gray
        $0.text = "^"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    /// 进度
    private lazy var progressView: RPCircularProgress = {
        $0.trackTintColor = UIColor.white
        $0.progressTintColor = UIColor.init(red: 74 / 255, green: 144 / 255, blue: 226 / 255, alpha: 1)
        $0.thicknessRatio = 0.5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(RPCircularProgress())
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        addSubview(messageLabel)
        addSubview(iconLabel)
        addSubview(progressView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
        ])
        
        NSLayoutConstraint.activate([
            iconLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 2),
            iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 6),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 40),
            progressView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// MARK - RefreshStateful
extension UserProgressView: RefreshStateful {
    
    public func refresher(_ refresher: Refresher, didChangeState state: RefreshState) {
        switch state {
        case .idle:
            break
        case .pulling:
            break
        case .willRefresh:
            break
        case .refreshing:
            break
        case .disabled:
            break
        }
    }
    
    public func refresher(_ refresher: Refresher, didChangeOffset offset: CGFloat) {
        
        let progress = offset/refresher.height
        if progress <= 0.01 {
            progressView.updateProgress(0)
        } else {
            progressView.updateProgress(progress)
        }
    }
}

