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

struct MessageNodeViewFlag {
    
    static let Avatar = 1
    static let Content = 2
    static let Placeholder = 3
}

struct MNVCustomMenuKey {
    
    static let Title = "title"
    static let Action = "action"
}

struct MNVCustomMenuTitle {
    
    static let More = "More..."
}

struct MNVCustomMenuAction {
    
    static let Copy = "copy:"
    static let Delete = "delete:"
    static let More = "more:"
}

struct MessageNodeViewCustomMenuItemOptions : OptionSetType {
    
    let rawValue: UInt
    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    static let Copy = MessageNodeViewCustomMenuItemOptions(rawValue: 1<<0)
    static let Delete = MessageNodeViewCustomMenuItemOptions(rawValue: 1<<1)
    static let More = MessageNodeViewCustomMenuItemOptions(rawValue: 1<<2)
}

@objc protocol MessageNodeViewDelegate : NSObjectProtocol {
    optional func messageViewDidTappedAvatar(messageNodeView: MessageNodeView)
    optional func messageViewDidMoreMenuTapped(messageNodeView: MessageNodeView)
}

class MessageNodeView: UIView {

    // MARK: - Properties
    weak var delegate: MessageNodeViewDelegate?
    weak var cell: UITableViewCell?
    
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
        _messageNodeViewInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _messageNodeViewInit()
    }
    
    // MARK: - Menu
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        let options = customMenuItemOptions()
        let actionDescription = action.description
        
        if actionDescription == MNVCustomMenuAction.Copy && options.contains(.Copy) {
            return true
        }
        if actionDescription == MNVCustomMenuAction.Delete && options.contains(.Delete) {
            return true
        }
        if actionDescription == MNVCustomMenuAction.More && options.contains(.More) {
            return true
        }

        return false
    }
    
    override func copy(sender: AnyObject?) {
        fatalError("copy: must be implemented")
    }
    
    override func delete(sender: AnyObject?) {
        fatalError("delete: must be implemented")
    }
    
    func more(sender: AnyObject?) {
        if delegate != nil && delegate!.respondsToSelector("messageViewDidMoreMenuTapped:") {
            delegate!.messageViewDidMoreMenuTapped!(self)
        }
    }
    
    // MARK: - Event Response
    func avatarButtonTapped(sender: UIButton) {
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
            let customMenuItems = _decodedMenuItems(withOptions: customMenuItemOptions())
            var menuItmes: [UIMenuItem] = []
            for itemInfo in customMenuItems {
                let menuItem = UIMenuItem(title: itemInfo[MNVCustomMenuKey.Title]!, action: Selector(itemInfo[MNVCustomMenuKey.Action]!))
                menuItmes += [menuItem]
            }
            menuController.menuItems = menuItmes
            let messageView = viewWithTag(MessageNodeViewFlag.Content)!
            menuController.setTargetRect(messageView.frame, inView: contentStackView)
            menuController.setMenuVisible(true, animated: true)
        }
    }
    
    // MARK: - Public Methods
    func contentView() -> UIView {
        fatalError("contentView() should be override")
    }
    
    func customMenuItemOptions() -> MessageNodeViewCustomMenuItemOptions {
        return .Copy
    }
    
    // MARK: - Private Methods
    private func _messageNodeViewInit() {
        avatarView.tag = MessageNodeViewFlag.Avatar
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
        messageView.tag = MessageNodeViewFlag.Content
        
        _placeholderView.tag = MessageNodeViewFlag.Placeholder
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
    
    private func _decodedMenuItems(withOptions options: MessageNodeViewCustomMenuItemOptions) -> [Dictionary<String, String>] {
        var menuItemInfos: [Dictionary<String, String>] = []
        if options.contains(.More) {
            menuItemInfos += [[MNVCustomMenuKey.Title: MNVCustomMenuTitle.More, MNVCustomMenuKey.Action: MNVCustomMenuAction.More]]
        }
        
        return menuItemInfos
    }
    
    // MARK: - Getters & Setters
    var messageFromType: MessageFromType {
        get {
            return _messageFromType
        }
        set {
            if _messageFromType != newValue {
                let avatar = viewWithTag(MessageNodeViewFlag.Avatar)!
                let content = viewWithTag(MessageNodeViewFlag.Content)!
                let placeholder = viewWithTag(MessageNodeViewFlag.Placeholder)!
                
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
