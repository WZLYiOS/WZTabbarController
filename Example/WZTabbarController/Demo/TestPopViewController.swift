//
//  TestPopViewController.swift
//  Created by CocoaPods on 2024/1/19
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import UIKit
import WZTransition

class TestPopViewController: UIViewController {

    private var presentAnimator: WZPresentAnimator!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.presentAnimator = WZPresentAnimator(self)
        self.presentAnimator.dialog { (config) in
            config.dialogType = .preferSize
            config.maskViewBackgroundColor = UIColor.black.withAlphaComponent(0.5)
            config.animateType = .direction(type: .bottom)
            config.duration = 0.5
            config.isShowMask = true
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
