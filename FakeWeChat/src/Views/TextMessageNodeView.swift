//
//  TextMessageNodeView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class TextMessageNodeView: MessageNodeView {
    
    // MARK: - Life Cycle
    // MARK: - Override
    override func contentView() -> UIView {
        return _contentView
    }
    
    // MARK: - Menu
    override func copy(sender: AnyObject?) {
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = _contentView.messageTextView.text
        print("copied")
    }
    
    override func delete(sender: AnyObject?) {
        print("deleted")
    }
    
    override func customMenuItemOptions() -> MessageNodeViewCustomMenuItemOptions {
        return [.Copy, .Delete, .More]
    }
    
    // MARK: - Property
    
    var textMessage = "" {
        didSet {
            _contentView.message = textMessage
        }
    }
    
    // MARK: - Private Properties
    private let _contentView = BubbleTextView()
    
}
