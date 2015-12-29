//
//  SimpleSearchResultViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit

class SimpleSearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           return results.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !searching {
            performSearch()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            searchController?.active = false
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if !searching && keywords != nil {
            cell.textLabel?.text = "搜索：\"\(keywords!)\""
            cell.textLabel?.textColor = UIColor.flatBlueColorDark()
        }
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        keywords = searchController.searchBar.text
        searching = false
        tableView.reloadData()
    }
    
    // MARK: - Public Properties
    var keywords: String?
    var searchController: UISearchController?
    lazy var tableView = UITableView()
    var searching = false
    lazy var results: [AnyObject] = []
    
    // MARK: - Private Properties
    
    // MARK: - Public Methods
    func performSearch() {
        fatalError("performSearch must be implemented")
    }

}
