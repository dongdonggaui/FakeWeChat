//
//  MessageNodeView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

enum MessageFromType: Int {
    case Incoming = 1
    case Outgoing = 2
}

enum MessageNodeViewFlag: Int {
    case Avatar = 1
    case Content = 2
    case Placeholder = 3
}

enum MessageNodeViewCustomMenuKey: String {
    case Title = "title"
    case Action = "action"
}

@objc protocol MessageNodeViewDelegate: NSObjectProtocol {
    optional func messageViewDidTappedAvatar(messageNodeView: MessageNodeView)
}

class MessageNodeView: UIView {

    // MARK: - Properties
    weak var delegate: MessageNodeViewDelegate?
    
    let contentStackView = UIStackView()
    
    let avatarView = UIView()
    let avatarButton = UIButton(type: .Custom)
    let avatarImageView = UIImageView()
    
    // MARK: - Private Properties
    private var _messageFromType = MessageFromType.Incoming
    private var _placeholderView = UIView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        messageNodeViewInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        messageNodeViewInit()
    }
    
    // MARK: - Menu
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: - Event Response
    private func avatarButtonTapped(sender: UIButton) {
        if let sDelegate = delegate {
            if sDelegate.respondsToSelector("messageViewDidTappedAvatar:") {
                sDelegate.messageViewDidTappedAvatar!(self)
            }
        }
    }
    
    func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .Began {
            becomeFirstResponder()
            let menuController = UIMenuController.sharedMenuController()
            if let customMenuItems = customMenuItems() {
                var menuItmes: [UIMenuItem] = []
                for itemInfo in customMenuItems {
                    let menuItem = UIMenuItem(title: itemInfo[MessageNodeViewCustomMenuKey.Title.rawValue]!, action: Selector(itemInfo[MessageNodeViewCustomMenuKey.Action.rawValue]!))
                    menuItmes += [menuItem]
                }
                menuController.menuItems = menuItmes
            }
            let messageView = viewWithTag(MessageNodeViewFlag.Content.rawValue)!
            menuController.setTargetRect(messageView.frame, inView: contentStackView)
            menuController.setMenuVisible(true, animated: true)
        }
    }
    
    // MARK: - Public Methods
    func contentView() -> UIView {
        fatalError("contentView() should be override")
    }
    
    func customMenuItems() -> [Dictionary<String, String>]? {
        return nil
    }
    
    // MARK: - Private Methods
    private func messageNodeViewInit() {
        avatarView.tag = MessageNodeViewFlag.Avatar.rawValue
        avatarView.addSubview(avatarImageView)
        avatarView.addSubview(avatarButton)
        avatarImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(avatarView)
        }
        avatarButton.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(avatarView)
        }
        avatarView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(50, 50))
        }
        avatarButton.addTarget(self, action: "avatarButtonTapped:", forControlEvents: .TouchUpInside)
        
        contentStackView.axis = .Horizontal
        contentStackView.distribution = .Fill
        contentStackView.spacing = 8
        
        addSubview(contentStackView)
        contentStackView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        let messageView = self.contentView()
        messageView.tag = MessageNodeViewFlag.Content.rawValue
        
        _placeholderView.tag = MessageNodeViewFlag.Placeholder.rawValue
        _placeholderView.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        _placeholderView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        contentStackView.addArrangedSubview(avatarView)
        contentStackView.addArrangedSubview(messageView)
        contentStackView.addArrangedSubview(_placeholderView)
        
        // menu action
        let longPress = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
        longPress.minimumPressDuration = 1
        messageView.addGestureRecognizer(longPress)
        messageView.userInteractionEnabled = true
        
        // for test
        avatarView.backgroundColor = UIColor.lightGrayColor()
        messageView.backgroundColor = UIColor.orangeColor()
    }
    
    // MARK: - Getters & Setters
    var messageFromType: MessageFromType {
        get {
            return _messageFromType
        }
        set {
            if _messageFromType != newValue {
                let avatar = viewWithTag(MessageNodeViewFlag.Avatar.rawValue)!
                let content = viewWithTag(MessageNodeViewFlag.Content.rawValue)!
                let placeholder = viewWithTag(MessageNodeViewFlag.Placeholder.rawValue)!
                
                switch newValue {
                case .Incoming:
                    contentStackView.removeArrangedSubview(content)
                    contentStackView.addArrangedSubview(content)
                    contentStackView.removeArrangedSubview(placeholder)
                    contentStackView.addArrangedSubview(placeholder)
                case .Outgoing:
                    contentStackView.removeArrangedSubview(content)
                    contentStackView.addArrangedSubview(content)
                    contentStackView.removeArrangedSubview(avatar)
                    contentStackView.addArrangedSubview(avatar)
                }
            }
            _messageFromType = newValue
        }
    }

}
