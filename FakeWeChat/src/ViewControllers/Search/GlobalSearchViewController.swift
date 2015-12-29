//
//  GlobalSearchViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class GlobalSearchViewController: UISearchController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView()
        stackView.alignment = .Center
        stackView.distribution = .EqualSpacing
        stackView.layoutMargins = UIEdgeInsetsMake(0, 20, 0, 20)
        stackView.layoutMarginsRelativeArrangement = true
        stackView.backgroundColor = UIColor.flatBlueColor()
        
        let timelineButton = UIButton(type: .Custom)
        timelineButton.setImage(AppContext.globalSearchTimelineIcon(), forState: .Normal)
        let timelineLabel = UILabel()
        timelineLabel.text = "朋友圈"
        timelineLabel.font = UIFont.systemFontOfSize(12)
        timelineLabel.textColor = UIColor.grayColor()
        let timelineStackView = UIStackView()
        timelineStackView.axis = .Vertical
        timelineStackView.alignment = .Center
        timelineStackView.spacing = 5
        timelineStackView.addArrangedSubview(timelineButton)
        timelineStackView.addArrangedSubview(timelineLabel)
        
        let articleButton = UIButton(type: .Custom)
        articleButton.setImage(AppContext.globalSearchArticleIcon(), forState: .Normal)
        let articleLabel = UILabel()
        articleLabel.text = "文章"
        articleLabel.font = UIFont.systemFontOfSize(12)
        articleLabel.textColor = UIColor.grayColor()
        let articleStackView = UIStackView()
        articleStackView.axis = .Vertical
        articleStackView.alignment = .Center
        articleStackView.spacing = 5
        articleStackView.addArrangedSubview(articleButton)
        articleStackView.addArrangedSubview(articleLabel)
        
        let celebrityButton = UIButton(type: .Custom)
        celebrityButton.setImage(AppContext.globalSearchCelebrityIcon(), forState: .Normal)
        let celebrityLabel = UILabel()
        celebrityLabel.text = "公众号"
        celebrityLabel.font = UIFont.systemFontOfSize(12)
        celebrityLabel.textColor = UIColor.grayColor()
        let celebrityStackView = UIStackView()
        celebrityStackView.axis = .Vertical
        celebrityStackView.alignment = .Center
        celebrityStackView.spacing = 5
        celebrityStackView.addArrangedSubview(celebrityButton)
        celebrityStackView.addArrangedSubview(celebrityLabel)
        
        stackView.addArrangedSubview(timelineStackView)
        stackView.addArrangedSubview(articleStackView)
        stackView.addArrangedSubview(celebrityStackView)
        
        view.addSubview(stackView)
        stackView.snp_makeConstraints { (make) -> Void in
            contextTopMarginConstrait = make.top.equalTo(100).constraint
            make.leading.trailing.equalTo(view)
            make.height.equalTo(100)
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ [weak self] (context) -> Void in
            if self == nil {
                return
            }
            if self!.tq_isMinimumWindowHeight() {
                self!.contextTopMarginConstrait?.updateOffset(68)
            } else {
                self!.contextTopMarginConstrait?.updateOffset(100)
            }
            }, completion: { [weak self] (context) -> Void in
                self?.view.layoutIfNeeded()
        })
    }
    
    // MARK: - Properties
    private var contextTopMarginConstrait: Constraint?

}
