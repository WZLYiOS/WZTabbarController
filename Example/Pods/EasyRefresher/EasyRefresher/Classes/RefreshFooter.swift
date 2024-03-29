//
//  RefreshFooter.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/26
//  Copyright © 2019 Pircate. All rights reserved.
//

open class RefreshFooter: RefreshComponent, FooterRefresher {
    
    override var arrowDirection: ArrowDirection { .up }
    
    private lazy var constraintOfTopAnchor: NSLayoutConstraint? = {
        guard let scrollView = scrollView, isDescendant(of: scrollView) else { return nil }
        
        let constraint = topAnchor.constraint(equalTo: scrollView.topAnchor)
        constraint.isActive = true
        
        return constraint
    }()
    
    open override func updateConstraints() {
        super.updateConstraints()
        
        guard let scrollView = scrollView else { return }
        
        constraintOfTopAnchor?.constant = scrollView.contentSize.height
    }
    
    override func prepare() {
        super.prepare()
        
        alpha = 0
        setTitle("pull_up_to_load_more".localized(), for: .pulling)
        setTitle("release_to_load_more".localized(), for: .willRefresh)
    }
    
    override func willBeginRefreshing(completion: @escaping () -> Void) {
        guard let scrollView = scrollView else { return }
        
        alpha = 1
        
        UIView.animate(withDuration: 0.25, animations: {
            scrollView.contentInset.bottom = self.originalInset.bottom + self.height
            scrollView.changed_inset.bottom = self.height
        }, completion: { _ in completion() })
    }
    
    override func didEndRefreshing(completion: @escaping () -> Void) {
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            scrollView.contentInset.bottom -= scrollView.changed_inset.bottom
            scrollView.changed_inset.bottom = 0
        }, completion: { _ in completion() })
    }
    
    override func scrollViewContentInsetDidReset(_ scrollView: UIScrollView) {
        scrollView.contentInset.bottom -= scrollView.changed_inset.bottom
        scrollView.changed_inset.bottom = 0
    }
    
    override func scrollViewContentOffsetDidChange(_ scrollView: UIScrollView) {
        let offset: CGFloat
        
        if scrollView.refreshInset.top + scrollView.contentSize.height >= scrollView.bounds.height {
            offset = scrollView.contentOffset.y
                + scrollView.bounds.height
                - scrollView.contentSize.height
                - scrollView.refreshInset.bottom
        } else {
            offset = scrollView.contentOffset.y + scrollView.refreshInset.top
        }
        
        offsetDidChange(-offset)
        
        didChangeAlpha(by: -offset)
        
        guard isEnabled else { return }
        
        if scrollView.isDragging, triggerAutoRefresh(by: offset) {
            beginRefreshing()
            return
        }
        
        didChangeState(by: -offset)
    }
    
    override func scrollViewContentSizeDidChange(_ scrollView: UIScrollView) {
        super.scrollViewContentSizeDidChange(scrollView)
        
        setNeedsUpdateConstraints()
    }
    
    func triggerAutoRefresh(by offset: CGFloat) -> Bool { false }
}
