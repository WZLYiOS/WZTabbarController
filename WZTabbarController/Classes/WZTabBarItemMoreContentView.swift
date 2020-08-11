//
//  WZTabBarItemMoreContentView.swift
//  WZTabbarController
//
//  Created by LiuSky on 08/26/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit


/// MARK - WZTabBarItemMoreContentView
@objcMembers open class WZTabBarItemMoreContentView: WZTabBarItemContentView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.title = NSLocalizedString("More_TabBarItem", bundle: Bundle(for:WZTabBarController.self), comment: "")
        self.image = systemMore(highlighted: false)
        self.selectedImage = systemMore(highlighted: true)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func systemMore(highlighted isHighlighted: Bool) -> UIImage? {
        let image = UIImage.init()
        let circleDiameter  = isHighlighted ? 5.0 : 4.0
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: 32, height: 32), false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(1.0)
            for index in 0...2 {
                let tmpRect = CGRect.init(x: 5.0 + 9.0 * Double(index), y: 14.0, width: circleDiameter, height: circleDiameter)
                context.addEllipse(in: tmpRect)
                image.draw(in: tmpRect)
            }

            if isHighlighted {
                context.setFillColor(UIColor.blue.cgColor)
                context.fillPath()
            } else {
                context.strokePath()
            }
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
        
        return nil
    }
    
}
