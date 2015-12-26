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

@objc protocol MessageNodeViewDelegate: NSObjectProtocol {
    optional func messageViewDidTappedAvatar(messageNodeView: MessageNodeView)
}

@objc protocol MessageNodeViewProtocol {
    func messageNodeViewContentView(messageNodeView: MessageNodeView) -> UIView
}

class MessageNodeView: UIView {

    // MARK: - Properties
    weak var delegate: MessageNodeViewDelegate?
    
    lazy private var _messageFromType = MessageFromType.Incoming
    
    let contentStackView = UIStackView()
    
    let avatarView = UIView()
    let avatarButton = UIButton(type: .Custom)
    let avatarImageView = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        contentStackView.alignment = .Leading
        contentStackView.distribution = .Fill
        self.addSubview(contentStackView)
        contentStackView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        let messageView = self.contentView()
        contentStackView.addArrangedSubview(avatarView)
        contentStackView.addArrangedSubview(messageView)
        
        // for text
        avatarView.backgroundColor = UIColor.lightGrayColor()
        messageView.backgroundColor = UIColor.orangeColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Event Response
    func avatarButtonTapped(sender: UIButton) {
        if let sDelegate = delegate {
            if sDelegate.respondsToSelector("messageViewDidTappedAvatar:") {
                sDelegate.messageViewDidTappedAvatar!(self)
            }
        }
    }
    
    // MARK: - Public
    func contentView() -> UIView {
        fatalError("contentView() should be override")
    }
    
    // MARK: - Getters & Setters
    var messageFromType: MessageFromType {
        get {
            return _messageFromType
        }
        set {
            if _messageFromType != newValue {
                switch newValue {
                case .Incoming:
                    self.contentStackView.removeArrangedSubview(self.contentView())
                    self.contentStackView.addArrangedSubview(self.contentView())
                case .Outgoing:
                    self.contentStackView.removeArrangedSubview(self.avatarView)
                    self.contentStackView.addArrangedSubview(self.avatarView)
                }
            }
            _messageFromType = newValue
        }
    }

}
