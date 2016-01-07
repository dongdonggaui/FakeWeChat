//
//  ChatViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/26.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController, MessageListViewDelegate {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(_messageListView)
        _messageListView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        _messageListView.tableView.separatorStyle = .None
        _messageListView.delegate = self
        
        _cancelItem.target = self
        _cancelItem.action = "_cancelItemTapped:"
        
        navigationItem.rightBarButtonItem = _rightItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Properties
    private lazy var _messageListView: MessageListView =  MessageListView()
    private lazy var _cancelItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: nil, action: nil)
    private lazy var _rightItem: UIBarButtonItem = {
        let rightItem = UIBarButtonItem()
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
        rightItem.setTitleTextAttributes(attributes, forState: .Normal)
        rightItem.title = String.fontAwesomeIconWithName(.User)
        return rightItem
    }()
    
    // MARK: - MessageListViewDelegate
    func messageListView(messageListView: MessageListView, didTappedMoreMenuItemInCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        _switchToEditMode(true)
    }
    
    // MARK: - Event Response
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func _cancelItemTapped(sender: UIBarButtonItem) {
        
        _switchToEditMode(false)
    }
    
    // MARK: - Private Methods
    private func _switchToEditMode(edit: Bool) {
        
        _messageListView.editing = edit
        if edit {
            navigationItem.leftBarButtonItem = _cancelItem
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = _rightItem
        }
    }

}
