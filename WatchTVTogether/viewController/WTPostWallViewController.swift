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
        postTableView.rowHeight = 300
        postTableView.dataSource = dataSource
        postTableView.delegate = self
        postTableView.separatorStyle = .None
        
        setGradient()
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("SpoilAlert", comment: "")
        
    }
    
//    func setTabIcon(){
//        self.tabBarController.
//    }
    
    let myGradientView = WTGradientView()
    
    func setGradient(){
//        let firstColor = UIColor(red: 232.0/255.0, green: 121.0/255.0, blue: 117.0/255.0, alpha: 1.0)
//        let secondColor = UIColor(red: 243.0/255.0, green: 199.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        
//        let view = WTGradientView()
//        let a = self.navigationController?.navigationBar.frame
//        myGradientView.frame = a!
//        myGradientView.backgroundColor = UIColor.yellowColor()
//        myGradientView.gradientWithColors(firstColor, secondColor)

//        navigationController?.navigationBar.insertSubview(myGradientView, atIndex: 0)
    }
    
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
    
//    var cell:UITableViewCell?
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kPostCellIdentifier)
//        
//        if cell == nil{
//            cell = WTPostTableViewCell()
//        }
//        
//        if var wrappedCell = cell {
//
//            setUpCell(&wrappedCell, indexPath: indexPath)
//            wrappedCell.layoutIfNeeded()
//            return 196.0
////            return calculateHeightForConfiguredSizingCell(wrappedCell)
//        }
//        
//        return CGFloat(0.0)
//        
//    }
    
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