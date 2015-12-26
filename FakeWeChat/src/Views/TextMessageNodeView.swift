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

class TextMessageNodeView: MessageNodeView {
    
    // MARK: - Property
    var textMessage = "" {
        didSet {
            _contentView.message = textMessage
        }
    }
    private let _contentView = BubbleTextView()
    
    // MARK: - Override
    override func contentView() -> UIView {
        return _contentView
    }
}
