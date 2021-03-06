//
//  BubbleTextView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import YYKit
import SnapKit

class BubbleTextView: UIView {

    var textWidth: CGFloat = 0
    var message = "" {
        didSet {
            messageTextView.text = message
            invalidateIntrinsicContentSize()
        }
    }
    let messageBubbleView = UIImageView()
    let messageTextView = UITextView()
    
    deinit {
        KVOController.removeObserver(self, forKeyPath: "frame")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageTextView.font = UIFont.systemFontOfSize(14)
        messageTextView.textColor = UIColor.blackColor()
        messageTextView.scrollEnabled = false
        messageTextView.editable = false
        messageTextView.selectable = false
        
        addSubview(messageBubbleView)
        addSubview(messageTextView)
        
        messageBubbleView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        messageTextView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        let options = NSKeyValueObservingOptions([.Old, .New])
        KVOController.observe(self, keyPath: "frame", options: options, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func intrinsicContentSize() -> CGSize {
        var size = (message as NSString).sizeForFont(messageTextView.font, size: CGSizeMake(width - 70, CGFloat.max), mode: NSLineBreakMode.ByWordWrapping)
        size.width += 20
        size.height += 20
        return size
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let path = keyPath {
            if path == "frame" {
                let newValue = (change![NSKeyValueChangeNewKey] as! NSValue).CGRectValue()
                let oldValue = (change![NSKeyValueChangeOldKey] as! NSValue).CGRectValue()
                if newValue.width != oldValue.width {
                    invalidateIntrinsicContentSize()
                }
            }
        }
    }

}
