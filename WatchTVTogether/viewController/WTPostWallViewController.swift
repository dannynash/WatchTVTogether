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
        postTableView.registerNib(UINib(nibName: "WTResponseView", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kWTResponseViewIdentifier)
        
        postTableView.rowHeight = 300
        postTableView.dataSource = dataSource
        postTableView.delegate = self
        postTableView.separatorStyle = .None
        
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("SpoilAlert", comment: "")
        
        
        WTPostsProxy.shareInstance.fetchPosts { [weak self](result) -> Void in
            if let sSelf = self{
                sSelf.dataSource.posts = result
                WTFakeTmpStorage.shareInstance.post = result[0]
                sSelf.postTableView.reloadData()
            }
        }

        self.navigationItem.hidesBackButton = true
        
//        navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: false)

    }
    
    let myGradientView = WTGradientView()
    
    
    override func viewDidLayoutSubviews() {
        self.myGradientView.gradientWithColors(UIColor.whiteColor(), UIColor.blueColor())
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

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 207.0
        } else if isTheLastCellOfSection(indexPath) {
            return 35.0
        } else {
            return 30.0
        }
    }
    
    func isTheLastCellOfSection(indexPath: NSIndexPath) -> Bool{
        let lastResponseNum = dataSource.posts[indexPath.section].lastResponse.count
        let a = Int(lastResponseNum) + 1
        return indexPath.row == a
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

        let post = dataSource.posts[indexPath.section]
        self.performSegueWithIdentifier(WTSegue.kPostWallToProgram, sender: post)
    }
    
}