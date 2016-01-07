//
//  SearchResultViewController.swift
//  FakeWeChat
//
//  Created by huangluyang on 15/12/29.
//  Copyright © 2015年 huangluyang. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class MessageArchiveSearchResultViewController: SimpleSearchResultViewController, UISearchResultsUpdating {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(SearchResultTableViewCell.self, forCellReuseIdentifier: "resultCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if !searching {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        self.configureResultCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configureResultCell(cell: SearchResultTableViewCell, atIndexPath indexPath: NSIndexPath) {
        let result = results[indexPath.row]
        cell.simpleView.titleLabel.text = result as? String
        cell.simpleView.timeLabel.text = "2015/12/29"
        cell.simpleView.avatarView.backgroundColor = UIColor.flatRedColor()
        if indexPath.row == 2 {
            cell.simpleView.detailLabel.text = "long detail test long detail test long detail test long detail test long detail test long detail test long detail test"
        } else {
            cell.simpleView.detailLabel.text = "detail"
        }
    }
    
    // MARK: - Public Methods
    override func performSearch() {
        searching = true
        _fakeSearchResults()
        searchController?.searchBar.resignFirstResponder()
        SVProgressHUD.showWithStatus(NSLocalizedString("加载中...", comment: "Search Loading"))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * NSEC_PER_SEC)), dispatch_get_main_queue()) { [weak self] () -> Void in
            SVProgressHUD.dismiss()
            self!.tableView.reloadData()
        }
    }
    
    // MARK: - Fake
    private func _fakeSearchResults() {
        results.removeAll()
        for _ in 0...10 {
//            _results += ["result -> \(TQMathUtl.randomInRange(1...100))"]
            results += ["result -> 1"]
        }
    }

}
