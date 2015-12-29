//
//  GlobalSearchViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

struct GSVLayoutInfo {
    static let TopMarginInitialRegular = CGFloat(144)
    static let TopMarginRegular = CGFloat(100)
    static let TopMarginInitialCompact = CGFloat(112)
    static let TopMarginCompact = CGFloat(68)
    static let ContentHeight = CGFloat(80)
    
    static let ContentFontSize = CGFloat(12)
    static let ContentPadding = CGFloat(5)
}

struct GSContentTitle {
    static let Timeline = NSLocalizedString("朋友圈", comment: "Timeline")
    static let Article = NSLocalizedString("文章", comment: "Articel")
    static let Celebrity = NSLocalizedString("公众号", comment: "Celebrity")
}

enum GSButtonTag : Int {
    case Unknown = 0
    case Timeline = 1
    case Article = 2
    case Celebrity = 3
}

class GlobalSearchViewController: UISearchController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(_blurBackgrounView)
        _blurBackgrounView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        let stackView = UIStackView()
        stackView.alignment = .Center
        stackView.distribution = .FillEqually
        stackView.layoutMargins = UIEdgeInsetsMake(0, 20, 0, 20)
        stackView.layoutMarginsRelativeArrangement = true
        
        let timelineStackView = _buttonViewWithImage(AppContext.globalSearchTimelineIcon(), text: GSContentTitle.Timeline, buttonTag: .Timeline)
        let articleStackView = _buttonViewWithImage(AppContext.globalSearchArticleIcon(), text: GSContentTitle.Article, buttonTag: .Article)
        let celebrityStackView = _buttonViewWithImage(AppContext.globalSearchCelebrityIcon(), text: GSContentTitle.Celebrity, buttonTag: .Celebrity)
        
        stackView.addArrangedSubview(timelineStackView)
        stackView.addArrangedSubview(articleStackView)
        stackView.addArrangedSubview(celebrityStackView)
        
        view.addSubview(stackView)
        stackView.snp_makeConstraints { (make) -> Void in
            _contextTopMarginConstrait = make.top.equalTo(GSVLayoutInfo.TopMarginInitialRegular).constraint
            make.leading.trailing.equalTo(view)
            make.height.equalTo(GSVLayoutInfo.ContentHeight)
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ [weak self] (context) -> Void in
            if self == nil {
                return
            }
            if self!.tq_isMinimumWindowHeight() {
                self!._contextTopMarginConstrait?.updateOffset(GSVLayoutInfo.TopMarginCompact)
            } else {
                self!._contextTopMarginConstrait?.updateOffset(GSVLayoutInfo.TopMarginRegular)
            }
            }, completion: { [weak self] (context) -> Void in
                self?.view.layoutIfNeeded()
        })
    }
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)
        
        //TODO: update animation
    }
    
    // MARK: - Properties
    private var _contextTopMarginConstrait: Constraint?
    private lazy var _blurBackgrounView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .Light)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    // MARK: - Event Response
    func buttonTapped(sender: UIButton) {
        
        let tag = GSButtonTag(rawValue: sender.tag) ?? .Unknown
        switch tag {
        case .Timeline:
            print("timeline")
        case .Article:
            print("article")
        case .Celebrity:
            print("celebrity")
        case .Unknown:
            break
        }
    }
    
    // MARK: - Private Methods
    private func _buttonViewWithImage(image: UIImage, text: String, buttonTag: GSButtonTag) -> UIStackView {
        
        let button = UIButton(type: .Custom)
        button.tag = buttonTag.rawValue
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFontOfSize(GSVLayoutInfo.ContentFontSize)
        label.textColor = UIColor.grayColor()
        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.alignment = .Center
        stackView.spacing = GSVLayoutInfo.ContentPadding
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label)
        
        return stackView
    }

}
