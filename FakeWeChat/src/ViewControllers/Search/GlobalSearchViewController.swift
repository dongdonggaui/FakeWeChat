//
//  GlobalSearchViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

struct GSNavigationInfo {
    
    static func height(state: GSState) -> CGFloat {
        var height = 0
        if state == .InactiveRegular || state == .ActiveRegular {
            height = 64
        } else {
            height = 32
        }
        return CGFloat(height)
    }
    
    static func topMargin(state: GSState) -> CGFloat {
        var topMargin = 0
        switch state {
        case .InactiveRegular:
            topMargin = 44
        case .InactiveCompact:
            topMargin = 32
        default:
            topMargin = 0
        }
        return CGFloat(topMargin)
    }
}

struct GSVLayoutInfo {
    
    static let ContentHeight = CGFloat(80)
    static let ContentFontSize = CGFloat(12)
    static let ContentPadding = CGFloat(5)
    
    static func topMargin(state: GSState) -> CGFloat {
        var topMargin = 0
        switch state {
        case .InactiveRegular:
            topMargin = 144
        case .InactiveCompact:
            topMargin = 112
        case .ActiveRegular:
            topMargin = 100
        case .ActiveCompact:
            topMargin = 68
        }
        return CGFloat(topMargin)
    }
}

enum GSButtonTag : Int {
    case Unknown = 0
    case Timeline = 1
    case Article = 2
    case Celebrity = 3
}

enum GSState : Int {
    case InactiveRegular
    case InactiveCompact
    case ActiveRegular
    case ActiveCompact
}

class GlobalSearchViewController: UISearchController, UISearchBarDelegate {
    
    struct TitlePlaceholder {
        static let Timeline = NSLocalizedString("朋友圈", comment: "Timeline")
        static let Article = NSLocalizedString("文章", comment: "Articel")
        static let Celebrity = NSLocalizedString("公众号", comment: "Celebrity")
        static let SearchTimeline = NSLocalizedString("搜索朋友圈", comment: "Search Timeline")
        static let SearchArticle = NSLocalizedString("搜索文章", comment: "Search Article")
        static let SearchCelebrity = NSLocalizedString("搜索公众号", comment: "Search Celebrity")
        static let SearchTitle = NSLocalizedString("搜索", comment: "Search Placeholder")
        static let Cancel = NSLocalizedString("取消", comment: "Cancel")
        static let Back = NSLocalizedString("返回", comment: "Back")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupContentView()
        _setupNavigationBar()
        
        _searchBarIcon = _searchBar.imageForSearchBarIcon(.Search, state: .Normal)
        
        searchBar.hidden = true
        searchBar.delegate = self
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        presentingViewController?.tabBarController?.tabBar.hidden = true
        _searchBar.becomeFirstResponder()
        
        _cancelButton.snp_updateConstraints { (make) -> Void in
            make.trailing.equalTo(_navigationBar).offset(-8)
        }
        
        _state = _fetchCurrentState(true)
        UIView.animateWithDuration(0.25) { () -> Void in
            self._stackView.alpha = 1
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        presentingViewController?.tabBarController?.tabBar.hidden = false
        
        _cancelButton.snp_updateConstraints { (make) -> Void in
            make.trailing.equalTo(_navigationBar).offset(36)
        }
        
        _state = _fetchCurrentState(false)
        UIView.animateWithDuration(0.25) { () -> Void in
            self._stackView.alpha = 0
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        _popSubSearchViewController()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ [weak self] (context) -> Void in
            if self == nil {
                return
            }
            self!._state = self!._fetchCurrentState(true)
            }, completion: nil)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if searchBar == self.searchBar {
            _searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        active = false
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        if searchBar == self.searchBar {
            return false
        }
        return true
    }
    
    // MARK: - Private Properties
    private var _navigationBarTopConstraint: Constraint?
    private var _contextTopMarginConstraint: Constraint?
    private var _leadingMarginConstraint: Constraint?
    private var _searchBarIcon: UIImage?
    private lazy var _navigationBar = UINavigationBar(frame: CGRectMake(0, 20, 320, 44))
    private lazy var _searchBar = UISearchBar(frame: CGRectMake(0, 20, 0, 44))
    private lazy var _backButton = UIButton(type: .Custom)
    private lazy var _cancelButton = UIButton(type: .Custom)
    private lazy var _scrollView = UIScrollView()
    private lazy var _scrollContentView = UIView()
    private lazy var _stackView = UIStackView()
    
    private lazy var _blurBackgrounView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .Light)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    private var _state: GSState? {
        didSet {
            if _state == nil {
                return
            }
            _transitionToState(_state!)
        }
    }
    
    private weak var _currentSubSearchViewController: SimpleSearchResultViewController?
    
    // MARK: - Event Response
    func buttonTapped(sender: UIButton) {
        
        let tag = GSButtonTag(rawValue: sender.tag) ?? .Unknown
        switch tag {
        case .Timeline:
            print("timeline")
            let timelineSearch = TimelineSearchResultViewController()
            _searchBar.setImage(AppContext.globalSearchTimelineIcon(.Small), forSearchBarIcon: .Search, state: .Normal)
            _pushToSubSearchViewController(timelineSearch, placeholder: TitlePlaceholder.SearchTimeline)
        case .Article:
            print("article")
            let articleSearch = ArticleSearchResultViewController()
            _searchBar.setImage(AppContext.globalSearchArticleIcon(.Small), forSearchBarIcon: .Search, state: .Normal)
            _pushToSubSearchViewController(articleSearch, placeholder: TitlePlaceholder.SearchArticle)
        case .Celebrity:
            print("celebrity")
            let celebritySearch = CelebritySearchResultViewController()
            _searchBar.setImage(AppContext.globalSearchCelebrityIcon(.Small), forSearchBarIcon: .Search, state: .Normal)
            _pushToSubSearchViewController(celebritySearch, placeholder: TitlePlaceholder.SearchCelebrity)
        case .Unknown:
            break
        }
    }
    
    func backButtonTapped(sender: UIButton) {
        _popSubSearchViewController()
    }
    
    func cancelButtonTapped(sender: UIButton) {
        _searchBar.resignFirstResponder()
        active = false
    }
    
    // MARK: - Private Methods
    private func _setupContentView() {
        
        view.addSubview(_blurBackgrounView)
        _blurBackgrounView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        _scrollView.addSubview(_scrollContentView)
        _scrollView.alwaysBounceVertical = true
        _scrollView.keyboardDismissMode = .OnDrag
        
        view.addSubview(_scrollView)
        _scrollContentView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.edges.equalTo(_scrollView)
        }
        _scrollView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        _stackView.alignment = .Center
        _stackView.distribution = .FillEqually
        _stackView.layoutMargins = UIEdgeInsetsMake(0, 20, 0, 20)
        _stackView.layoutMarginsRelativeArrangement = true
        _stackView.alpha = 0
        
        let timelineStackView = _buttonViewWithImage(AppContext.globalSearchTimelineIcon(), text: TitlePlaceholder.Timeline, buttonTag: .Timeline)
        let articleStackView = _buttonViewWithImage(AppContext.globalSearchArticleIcon(), text: TitlePlaceholder.Article, buttonTag: .Article)
        let celebrityStackView = _buttonViewWithImage(AppContext.globalSearchCelebrityIcon(), text: TitlePlaceholder.Celebrity, buttonTag: .Celebrity)
        
        _stackView.addArrangedSubview(timelineStackView)
        _stackView.addArrangedSubview(articleStackView)
        _stackView.addArrangedSubview(celebrityStackView)
        
        _scrollContentView.addSubview(_stackView)
        _stackView.snp_makeConstraints { (make) -> Void in
            let top = GSVLayoutInfo.topMargin(_fetchCurrentState(false))
            _contextTopMarginConstraint = make.top.equalTo(_scrollContentView).offset(top).constraint
            make.leading.trailing.bottom.equalTo(_scrollContentView)
            make.height.equalTo(GSVLayoutInfo.ContentHeight)
        }
    }
    private func _setupNavigationBar() {
        
        _searchBar.searchBarStyle = .Minimal
        view.addSubview(_navigationBar)
        _navigationBar.snp_makeConstraints { (make) -> Void in
            let state = _fetchCurrentState(false)
            _navigationBarTopConstraint = make.top.equalTo(view).offset(GSNavigationInfo.topMargin(state)).constraint
            make.leading.trailing.equalTo(view)
            make.height.equalTo(GSNavigationInfo.height(state))
        }
        
        let navigationItem = UINavigationItem(title: "")
        
        _searchBar.delegate = self
        _searchBar.placeholder = TitlePlaceholder.SearchTitle
        _searchBar.tintColor = AppContext.globalSearchTintColor
        navigationItem.titleView = _searchBar
        
        _cancelButton.setTitle(TitlePlaceholder.Cancel, forState: .Normal)
        _cancelButton.setTitleColor(AppContext.globalSearchTintColor, forState: .Normal)
        _cancelButton.addTarget(self, action: "cancelButtonTapped:", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: _cancelButton)
        
        let backButton = UIButton(type: .Custom)
        backButton.setTitle(TitlePlaceholder.Back, forState: .Normal)
        backButton.setTitleColor(AppContext.globalSearchTintColor, forState: .Normal)
        backButton.addTarget(self, action: "backButtonTapped:", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        _navigationBar.items = [navigationItem]
        
        backButton.snp_makeConstraints { (make) -> Void in
            _leadingMarginConstraint = make.leading.equalTo(_navigationBar).offset(-36).constraint
            make.centerY.equalTo(_navigationBar).offset(10)
        }
        _searchBar.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(backButton.snp_trailing).offset(8)
            make.bottom.equalTo(_navigationBar)
            make.height.equalTo(44)
            make.trailing.equalTo(_cancelButton.snp_leading).offset(-8)
        }
        _cancelButton.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(_navigationBar).offset(36)
            make.centerY.equalTo(_navigationBar).offset(10)
        }
    }
    
    
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
    
    private func _transitionToState(state: GSState) {
        
        _contextTopMarginConstraint!.updateOffset(GSVLayoutInfo.topMargin(state))
        _navigationBarTopConstraint!.updateOffset(GSNavigationInfo.topMargin(state))
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    private func _fetchCurrentState(active: Bool) -> GSState {
        
        var state: GSState
        if tq_isMinimumWindowHeight() {
            state = active ? .ActiveCompact : .InactiveCompact
        } else {
            state = active ? .ActiveRegular : .InactiveRegular
        }
        return state
    }
    
    private func _pushToSubSearchViewController(subSearch: SimpleSearchResultViewController, placeholder: String?) {
        
        if _currentSubSearchViewController != nil {
            return
        }
        
        if placeholder != nil {
            _searchBar.placeholder = placeholder!
        }
        
        _currentSubSearchViewController = subSearch
        _searchBar.becomeFirstResponder()
        subSearch.searchController = self
        view.addSubview(subSearch.view)
        addChildViewController(subSearch)
        subSearch.view.snp_makeConstraints(closure: { (make) -> Void in
            make.leading.equalTo(view.snp_trailing)
            make.bottom.width.equalTo(view)
            make.top.equalTo(_searchBar.snp_bottom)
        })
        view.layoutIfNeeded()
        _leadingMarginConstraint!.updateOffset(8)
        subSearch.view.snp_updateConstraints(closure: { (make) -> Void in
            make.leading.equalTo(view.snp_trailing).offset(-UIApplication.tq_windowWidth())
        })
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    private func _popSubSearchViewController() {
        
        if _currentSubSearchViewController == nil {
            return
        }
        
        _searchBar.setImage(_searchBarIcon, forSearchBarIcon: .Search, state: .Normal)
        _searchBar.placeholder = TitlePlaceholder.SearchTitle
        _leadingMarginConstraint!.updateOffset(-36)
        
        let view = _currentSubSearchViewController!.view
        view.snp_updateConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp_trailing)
        }
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (finished) -> Void in
                view.removeFromSuperview()
                self._currentSubSearchViewController!.removeFromParentViewController()
                self._currentSubSearchViewController = nil
        }
    }

}
