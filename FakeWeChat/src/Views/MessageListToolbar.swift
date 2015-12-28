//
//  MessageListToolbar.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/28.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class MessageListToolbar: UIToolbar {

    // MARK: - Life Cycle
    init () {
        super.init(frame: CGRectMake(0, 0, UIApplication.tq_windowWidth(), 44))
        
        let redirectItem = _generateBarButtonItem(withImage: AppContext.redirectIcon(), action: "toolRedirect")
        let collectItem = _generateBarButtonItem(withImage: AppContext.collectIcon(), action: "toolCollect")
        let deleteItem = _generateBarButtonItem(withImage: AppContext.deleteIcon(), action: "toolDelete")
        let moreItem = _generateBarButtonItem(withImage: AppContext.moreIcon(), action: "toolMore")
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        setItems([flexibleItem, redirectItem, flexibleItem, collectItem, flexibleItem, deleteItem, flexibleItem, moreItem, flexibleItem], animated: false)
    }
    
    override convenience init(frame: CGRect) {
        self.init()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    // MARK: - Event Response
    func toolRedirect() {
        print("redirect")
    }
    
    func toolCollect() {
        print("collect")
    }
    
    func toolDelete() {
        print("delete")
    }
    
    func toolMore() {
        print("more")
    }
    
    // MARK: - Private Methods
    private func _generateBarButtonItem(withImage image: UIImage, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .Custom)
        button.setImage(image, forState: .Normal)
        button.sizeToFit()
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem(customView: button)
        return item
    }

}
