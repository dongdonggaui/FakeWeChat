//
//  TextMessageNodeView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import YYKit
import SnapKit

enum MessageFromType: Int {
    case Incoming = 1
    case Outgoing = 2
}

class TextMessageNodeView: UIView {
    
    lazy private var _messageFromType = MessageFromType.Incoming
    var messageFromType: MessageFromType {
        get {
            return _messageFromType
        }
        set {
            if _messageFromType != newValue {
                switch newValue {
                case .Incoming:
                    self.contentStackView.removeArrangedSubview(self.messageView)
                    self.contentStackView.addArrangedSubview(self.messageView)
                case .Outgoing:
                    self.contentStackView.removeArrangedSubview(self.avatarView)
                    self.contentStackView.addArrangedSubview(self.messageView)
                }
            }
            _messageFromType = newValue
        }
    }
    
    let contentStackView = UIStackView()

    let avatarView = UIView()
    let avatarButton = UIButton(type: .Custom)
    let avatarImageView = UIImageView()
    
    let messageView = BubbleTextView()
    
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
        
        contentStackView.axis = .Horizontal
        contentStackView.alignment = .Leading
        contentStackView.distribution = .Fill
        self.addSubview(contentStackView)
        contentStackView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        contentStackView.addArrangedSubview(avatarView)
        contentStackView.addArrangedSubview(messageView)
        
        // for text
        avatarView.backgroundColor = UIColor.lightGrayColor()
        messageView.backgroundColor = UIColor.orangeColor()
//        var text = NSMutableAttributedString(string: "test message")
//        var container = YYTextContainer(size: <#T##CGSize#>, insets: <#T##UIEdgeInsets#>)
        messageView.message = "message"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
