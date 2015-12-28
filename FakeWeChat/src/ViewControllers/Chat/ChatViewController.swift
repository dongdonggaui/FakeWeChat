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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ [weak self] (context) -> Void in
            if self == nil {
                return
            }
            self!._messageListView.willTransitionToSize(size)
            }, completion: nil)
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    // MARK: - Private Properties
    private lazy var _messageListView: MessageListView =  MessageListView()
    private lazy var _cancelItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: nil, action: nil)
    
    // MARK: - MessageListViewDelegate
    func messageListView(messageListView: MessageListView, didTappedMoreMenuItemInCell cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        _switchToEditMode(true)
    }
    
    // MARK: - Event Response
    func _cancelItemTapped(sender: UIBarButtonItem) {
        
        _switchToEditMode(false)
    }
    
    // MARK: - Private Methods
    private func _switchToEditMode(edit: Bool) {
        
        _messageListView.editing = edit
        if edit {
            navigationItem.leftBarButtonItem = _cancelItem
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }

}
