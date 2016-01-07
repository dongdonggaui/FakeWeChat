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
    override func awakeFromNib() {
        super.awakeFromNib()
        title = NSLocalizedString("聊天", comment: "Chat Title")
        tabBarItem.image = UIImage.fontAwesomeIconWithName(.Wechat, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonTapped:")
        
        _searchBar.height = 44
        _searchBar.searchBarStyle = .Minimal
        _searchBar.delegate = self
        _searchBar.placeholder = NSLocalizedString("搜索", comment: "Search Placeholder")
        _tableView.tableFooterView = UIView()
        _tableView.estimatedRowHeight = 67
        _tableView.tableHeaderView = _searchBar
        _tableView.contentOffset = CGPointMake(0, 44)
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
    
    // MARK: - Event Response
    func addButtonTapped(sender: UIBarButtonItem) {
        _viewLoader.showPopupMenu(inRect: CGRectMake(view.width - 44.5, 64, 40, 2))
    }
    
    // MARK: - Private Properties
    private lazy var _popupMenuItems: [KxMenuItem] = []
    private lazy var _searchBar = UISearchBar()
    private lazy var _searchResultViewController = GlobalSearchResultViewController()
    private lazy var _searchController: GlobalSearchViewController = {
        let sc = GlobalSearchViewController(searchResultsController: self._searchResultViewController)
        sc.searchResultsUpdater = self._searchResultViewController
        return sc
    }()
    private lazy var _viewLoader: ConversationViewLoader = {
        let vl = ConversationViewLoader(withViewController: self)
        return vl
    }()
    
}
