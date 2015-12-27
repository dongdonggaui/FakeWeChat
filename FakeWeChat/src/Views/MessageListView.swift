//
//  MessageListView.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/27.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

private let MessageListViewSearchBarInvisibleBottomMargin = CGFloat(0)
private let MessageListViewSearchBarVisibleBottomMargin = CGFloat(64)
private let MessageListViewSearchBarHeight = CGFloat(44)

class MessageListView: UIView, UITableViewDataSource, UITableViewDelegate, MessageNodeViewDelegate {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageListViewInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        messageListViewInit()
    }
    
    // MARK: - Public Properties
    let tableView = UITableView()

    // MARK: - Private Properties
    private let searchBar = UISearchBar()
    private var searchBarTopConstraint: Constraint?
    
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
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let textMessageCell = cell as! TextMessageTableViewCell
        let dice: UInt32 = 100
        let randomNum = Int(arc4random_uniform(dice)) + 1
        textMessageCell.textMessageNodeView.textMessage = "message --> \(randomNum)"
        textMessageCell.textMessageNodeView.messageFromType = indexPath.row % 2 == 0 ? .Incoming : .Outgoing
        textMessageCell.textMessageNodeView.delegate = self
    }
    
    // MARK: - MessageViewDelegate
    func messageViewDidTappedAvatar(messageNodeView: MessageNodeView) {
        print("tapped")
    }
    
    // MARK: - Private Methods
    private func messageListViewInit() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        addSubview(tableView)
        addSubview(searchBar)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        searchBar.snp_makeConstraints { (make) -> Void in
            searchBarTopConstraint = make.bottom.equalTo(self.snp_top).offset(MessageListViewSearchBarInvisibleBottomMargin).constraint
            make.leading.trailing.equalTo(self)
            make.height.equalTo(MessageListViewSearchBarHeight)
        }
        
        tableView.registerClass(TextMessageTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 60.0
        tableView.separatorStyle = .None
    }

}
