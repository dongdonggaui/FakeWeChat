//
//  ChatViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = TextMessageNodeView()
        self.view.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(300, 60))
            make.center.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
