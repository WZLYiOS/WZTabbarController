//
//  WZTabBarItemContainer.swift
//  WZTabbarController
//
//  Created by LiuSky on 08/26/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit

@objcMembers public class WZTabBarItemContainer: UIControl {
    
    internal init(_ target: AnyObject?, tag: Int) {
        super.init(frame: CGRect.zero)
        self.tag = tag
        self.addTarget(target, action: #selector(WZTabBar.selectAction(_:)), for: .touchUpInside)
        self.addTarget(target, action: #selector(WZTabBar.highlightAction(_:)), for: .touchDown)
        self.addTarget(target, action: #selector(WZTabBar.highlightAction(_:)), for: .touchDragEnter)
        self.addTarget(target, action: #selector(WZTabBar.dehighlightAction(_:)), for: .touchDragExit)
        self.backgroundColor = .clear
        self.isAccessibilityElement = true
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            if let subview = subview as? WZTabBarItemContentView {
                subview.frame = CGRect.init(x: subview.insets.left, y: subview.insets.top, width: bounds.size.width - subview.insets.left - subview.insets.right, height: bounds.size.height - subview.insets.top - subview.insets.bottom)
                subview.updateLayout()
            }
        }
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var b = super.point(inside: point, with: event)
        if !b {
            for subview in self.subviews {
                if subview.point(inside: CGPoint.init(x: point.x - subview.frame.origin.x, y: point.y - subview.frame.origin.y), with: event) {
                    b = true
                }
            }
        }
        return b
    }
    
}
