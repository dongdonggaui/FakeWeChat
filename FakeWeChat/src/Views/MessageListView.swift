//
//  MessageListView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/27.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

struct MLVLayoutInfo {
    
    static let TableViewTopInsetRegular = CGFloat(64)
    static let TableViewTopInsetCompact = CGFloat(32)
    
    static let SearchBarHeight = CGFloat(44)
    static let SearchBarInvisibleBottomMargin = CGFloat(0)
    
    static let ToolbarHeight = CGFloat(44)
    static let ToolbarInvisibleTopMargin = CGFloat(0)
}

@objc protocol MessageListViewDelegate : NSObjectProtocol {
    
    optional func messageListView(messageListView: MessageListView, didTappedMoreMenuItemInCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath)
    optional func messageListView(messageListView: MessageListView, didSelectedCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath)
    optional func messageListView(messageListView: MessageListView, didDeselectedCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath)
}

class MessageListView : UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UISearchControllerDelegate, UISearchBarDelegate, MessageNodeViewDelegate {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _messageListViewInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _messageListViewInit()
    }
    
    // MARK: - Override
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection == nil {
            return
        }
        _updateViewsLayout()
    }
    
    // MARK: - Public Properties
    let tableView = UITableView()
    weak var delegate: MessageListViewDelegate?
    var editing: Bool = false {
        didSet {
            tableView.setEditing(editing, animated: true)
            _updateViewsLayout()
        }
    }

    // MARK: - Private Properties
    private lazy var _searchBar = UISearchBar()
    private var _searchBarBottomConstraint: Constraint?
    private lazy var _functionToolbar = MessageListToolbar()
    private var _functionToolbarTopConstraint: Constraint?
    private lazy var _searchResultViewController: MessageArchiveSearchResultViewController = MessageArchiveSearchResultViewController()
    private lazy var _searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: self._searchResultViewController)
        sc.delegate = self
        sc.searchResultsUpdater = self._searchResultViewController
        sc.searchBar.delegate = self
        self._searchResultViewController.searchController = sc
        return sc
    }()
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !editing {
            return
        }
        print("selected at index --> \(indexPath)")
        if delegate == nil {
            return
        }
        if delegate!.respondsToSelector("messageListView:didSelectedCell:atIndexPath:") {
            delegate!.messageListView!(self, didSelectedCell: tableView.cellForRowAtIndexPath(indexPath)!, atIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if !editing {
            return
        }
        print("deselected at index --> \(indexPath)")
        if delegate == nil {
            return
        }
        if delegate!.respondsToSelector("messageListView:didDeselectedCell:atIndexPath:") {
            delegate!.messageListView!(self, didDeselectedCell: tableView.cellForRowAtIndexPath(indexPath)!, atIndexPath: indexPath)
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let textMessageCell = cell as! TextMessageTableViewCell
        let randomNum = TQMathUtl.randomInRange(1...100)
        textMessageCell.textMessageNodeView.textMessage = "message --> \(randomNum)"
        textMessageCell.textMessageNodeView.messageFromType = indexPath.row % 2 == 0 ? .Incoming : .Outgoing
        textMessageCell.textMessageNodeView.delegate = self
        textMessageCell.textMessageNodeView.cell = textMessageCell
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    // MARK: - MessageViewDelegate
    func messageViewDidTappedAvatar(messageNodeView: MessageNodeView) {
        print("avatar tapped")
    }
    
    func messageViewDidMoreMenuTapped(messageNodeView: MessageNodeView) {
        if delegate != nil && delegate!.respondsToSelector("messageListView:didTappedMoreMenuItemInCell:atIndexPath:") {
            let cell = messageNodeView.cell!
            let indexPath = tableView.indexPathForCell(cell)!
            delegate!.messageListView!(self, didTappedMoreMenuItemInCell: cell, atIndexPath: indexPath)
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if searchBar == _searchBar {
            _searchBar.hidden = true
            viewController.presentViewController(_searchController, animated: true, completion: nil)
        }
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            _searchResultViewController.performSearch()
        }
        return true
    }
    
    // MARK: - UISearchControllerDelegate
    func didPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.sizeToFit()
    }
    
    func didDismissSearchController(searchController: UISearchController) {
        _searchBar.hidden = false
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func _messageListViewInit() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.tableFooterView = UIView()
        
        let pan = UIPanGestureRecognizer { [weak self] (gesture) -> Void in
            if self == nil {
                return
            }
            if gesture.state == .Began {
                self!.endEditing(true)
            }
        }
        pan.delegate = self
        tableView.addGestureRecognizer(pan)
        
        _searchBar.placeholder = NSLocalizedString("Search", comment: "Message List View Search")
        _searchBar.delegate = self
        
        addSubview(tableView)
        addSubview(_searchBar)
        addSubview(_functionToolbar)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        _searchBar.snp_makeConstraints { (make) -> Void in
            _searchBarBottomConstraint = make.bottom.equalTo(self.snp_top).offset(MLVLayoutInfo.SearchBarInvisibleBottomMargin).constraint
            make.leading.trailing.equalTo(self)
            make.height.equalTo(MLVLayoutInfo.SearchBarHeight)
        }
        _functionToolbar.snp_makeConstraints { (make) -> Void in
            _functionToolbarTopConstraint = make.top.equalTo(self.snp_bottom).offset(MLVLayoutInfo.ToolbarInvisibleTopMargin).constraint
            make.leading.trailing.equalTo(self)
            make.height.equalTo(MLVLayoutInfo.ToolbarHeight)
        }
        
        tableView.registerClass(TextMessageTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 60.0
        tableView.separatorStyle = .None
    }
    
    private func _updateViewsLayout() {
        
        var tableViewTopInset: CGFloat
        
        if tq_isMinimumWindowHeight() {
            tableViewTopInset = MLVLayoutInfo.TableViewTopInsetCompact
        } else {
            tableViewTopInset = MLVLayoutInfo.TableViewTopInsetRegular
        }
        
        if _searchController.active {
            _searchBarBottomConstraint!.updateOffset(tableViewTopInset + MLVLayoutInfo.SearchBarHeight)
            return
        }
        
        let updateCustomConstraints = {[weak self] () -> Void in
            
            if self == nil {
                return
            }
            let searchBarOffset = self!.editing ? (tableViewTopInset + MLVLayoutInfo.SearchBarHeight) : MLVLayoutInfo.SearchBarInvisibleBottomMargin
            self!._searchBarBottomConstraint!.updateOffset(searchBarOffset)
            
            let toolbarOffset = self!.editing ? (-MLVLayoutInfo.ToolbarHeight) : MLVLayoutInfo.ToolbarInvisibleTopMargin
            self!._functionToolbarTopConstraint!.updateOffset(toolbarOffset)
        }
        
        let updateTableView = {[weak self] () -> Void in
            
            if self == nil {
                return
            }
            var contentInset = self!.tableView.contentInset
            contentInset.top = self!.editing ? (tableViewTopInset + MLVLayoutInfo.SearchBarHeight) : tableViewTopInset
            contentInset.bottom = self!.editing ? MLVLayoutInfo.ToolbarHeight : 0
            self!.tableView.contentInset = contentInset
            self!.tableView.scrollIndicatorInsets = contentInset
        }
        
        let updateOtherViews = {[weak self] () -> Void in
            self?.layoutIfNeeded()
        }
        
        if editing {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                updateTableView()
                }) { (finished) -> Void in
                    updateCustomConstraints()
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        updateOtherViews()
                    })
            }
        } else {
            updateCustomConstraints()
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                updateOtherViews()
                }) { (finished) -> Void in
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        updateTableView()
                    })
            }
        }
    }

}
