//
//  ConversationViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/25.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var _tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "聊天";
        _searchBar.height = 44
        _searchBar.translucent = true
        _searchBar.barTintColor = UIColor.flatWhiteColor()
        _searchBar.delegate = self
        _searchBar.placeholder = NSLocalizedString("搜索", comment: "Search Placeholder")
        _tableView.tableFooterView = UIView()
        _tableView.estimatedRowHeight = 67
        _tableView.tableHeaderView = _searchBar
        _tableView.contentOffset = CGPointMake(0, 44)
        
        let testItem = UIBarButtonItem(title: "test", style: .Plain, target: self, action: "test")
        navigationItem.rightBarButtonItem = testItem
    }
    
    func test() {
//        _searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = _tableView.indexPathForSelectedRow {
            _tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showChat", sender: nil)
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let avatarView = cell.viewWithTag(1) as? AvatarBadgeView {
            let path1 = "http://imgsrc.baidu.com/baike/pic/item/734f12f389d6b5860a46e0cf.jpg"
            let path2 = "http://img.315che.com/s/C201/109S/50r4/qths/oLU3/53U2/15.gif"
            var paths: [String]
            if indexPath.row == 0 {
                paths = [path1]
            } else if indexPath.row == 1 {
                paths = [path2]
            } else if indexPath.row == 2{
                paths = [path1, path2, path1]
            } else {
                paths = [path1, path2]
            }
            avatarView.setImagePaths(paths, placeholder: nil, completion: nil)
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        presentViewController(_searchController, animated: true, completion: nil)
        return false
    }
    
    // MARK: - Private Properties
    private lazy var _searchBar = UISearchBar()
    private lazy var _searchResultViewController = GlobalSearchResultViewController()
    private lazy var _searchController: GlobalSearchViewController = {
        let sc = GlobalSearchViewController(searchResultsController: self._searchResultViewController)
        return sc
    }()
}
