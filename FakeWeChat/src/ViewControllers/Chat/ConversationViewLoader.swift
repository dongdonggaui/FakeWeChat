//
//  ConversationViewLoader.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/31.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class ConversationViewLoader: NSObject {
    
    // MARK: - Life Cycle
    init(withViewController viewController: UIViewController?) {
        super.init()
        
        self.viewController = viewController
        setupPopupMenu()
    }
    
    override convenience init() {
        self.init(withViewController: nil)
    }
    
    // MARK: - Public Properties
    weak var viewController: UIViewController?
    
    // MARK: - Private Properties
    private lazy var _popupMenuItems: [KxMenuItem] = []
    
    // MARK: - Event Response
    func qunliaoTapped() {
        print("发起群聊")
    }
    
    func tianjiaTapped() {
        print("添加好友")
    }
    
    func saoTapped() {
        print("扫一扫")
    }
    
    func qianTapped() {
        print("收付款")
    }
    
    // MARK: - Public Methods
    func showPopupMenu(inRect rect: CGRect) {
        if viewController == nil {
            return
        }
        if KxMenu.isVisible() {
            KxMenu.dismissMenu()
        } else {
            KxMenu.showMenuInView(viewController!.view, fromRect: rect, menuItems: _popupMenuItems)
        }
    }
    
    func setupPopupMenu() {
        
        let qunliaoItem = KxMenuItem(title: "发起群聊", image: AppContext.clearIcon(withTitle: "💬"), target: self, action: "qunliaoTapped")
        let tianjiaItem = KxMenuItem(title: "添加朋友", image: AppContext.clearIcon(withTitle: "👬"), target: self, action: "tianjiaTapped")
        let saoyisaoItem = KxMenuItem(title: "扫一扫", image: AppContext.clearIcon(withTitle: "🔍"), target: self, action: "saoTapped")
        let shoufukuanItem = KxMenuItem(title: "收付款", image: AppContext.clearIcon(withTitle: "🏧"), target: self, action: "qianTapped")
        _popupMenuItems += [qunliaoItem, tianjiaItem, saoyisaoItem, shoufukuanItem]
    }
}
