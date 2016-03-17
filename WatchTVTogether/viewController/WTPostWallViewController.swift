//
//  WTPostWallViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTPostWallViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var postTableView: UITableView!
    
    let dataSource = WTPostsDataSource()
    
    override func viewDidLoad() {
        postTableView.registerNib(UINib(nibName: "WTPostTableViewCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kPostCellIdentifier)
        postTableView.estimatedRowHeight = 196.0
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.dataSource = dataSource
        postTableView.delegate = self
        postTableView.separatorStyle = .None
        
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("SpoilAlert", comment: "")

    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("SpoilAlert", comment: "")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WTSegue.kPostWallToProgram {
            let programVC = segue.destinationViewController as! WTProgramOverViewController
            let post = sender as! WTPost
            programVC.program = post.program
            

        }
    }
    
    var cell:UITableViewCell?
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kPostCellIdentifier)
        
        if cell == nil{
            cell = WTPostTableViewCell()
        }
        
        if var wrappedCell = cell {

            setUpCell(&wrappedCell, indexPath: indexPath)
            wrappedCell.layoutIfNeeded()
            return 196.0
//            return calculateHeightForConfiguredSizingCell(wrappedCell)
        }
        
        return CGFloat(0.0)
        
    }
    
    func setUpCell(inout cell:UITableViewCell, indexPath: NSIndexPath){
        let post = dataSource.posts[indexPath.row]
        (cell as! WTPostTableViewCell).setPost(post)
    }
    
    func calculateHeightForConfiguredSizingCell(cell:UITableViewCell) -> CGFloat {
        cell.layoutIfNeeded()
        let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        return size.height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        let post = dataSource.posts[indexPath.row]
        self.performSegueWithIdentifier(WTSegue.kPostWallToProgram, sender: post)
    }
    
}