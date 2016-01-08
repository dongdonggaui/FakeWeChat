//
//  MessageInputView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class MessageInputView: UIView {

    // MARK: - Properties
    lazy var inputMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }()

}

class InputToolViewBar: UIView {
    
    lazy var effectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        return view
    }()
    lazy var textView: GrowTextView = {
        let view = GrowTextView()
        return view
    }()
    lazy var topLine: UIView = {
        let line = UIView()
        return line
    }()
    lazy var speakButton: UIButton = {
        let button = UIButton(type: .Custom)
        return button
    }()
    lazy var inputSwitchButton: UIButton = {
        let button = UIButton(type: .Custom)
        return button
    }()
    lazy var textSwitchButton: UIButton = {
        let button = UIButton(type: .Custom)
        return button
    }()
}

class InputMediaQuickPicker: UIButton {
    
}

class InputExpressionQuickPicker: UIButton {
    
}

class RecordView: UIView {
    lazy var contentView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var rightImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var errorImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        return label
    }()
}

class GrowTextView: UIView {
    
    lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var textView: UITextView = {
        let view = UITextView()
        return view
    }()
}

class SelectAttachmentView: UIView {
    
    lazy var topLine: UIView = {
        let line = UIView()
        return line
    }()
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        return view
    }()
}

class AttachmentButton: UIButton {
    
}

class EmotionBoardView: UIView {
    
    lazy var topLine: UIView = {
        let line = UIView()
        return line
    }()
    lazy var bottomTabbar: UIView = {
        let view = UIView()
        return view
    }()
    lazy var bottomScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    lazy var bottomSubmitView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var bottomSubmitButton: UIButton = {
        let button = UIButton(type: .Custom)
        return button
    }()
    lazy var emotionView: SequencePageScrollView = {
        let view = SequencePageScrollView()
        return view
    }()
}

class SequencePageScrollView: UIView {
    
}

class EmotionTabbarItemView: UIView {
    
    lazy var bacgroundImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var selectedBackgroundImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var rightLine: UIView = {
        let line = UIView()
        return line
    }()
    lazy var badgeImageView: UIImageView = {
        let view = UIImageView()
        view.hidden = true
        return view
    }()
}
