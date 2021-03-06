//
//  WTDetailThreadViewController.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTDetailThreadViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var responseTableView: UITableView!
    var thread:WTDetailThread?
    
    func setThread(thread:WTDetailThread){
        self.thread = thread
        self.fetchThread()
    }
    
    func fetchThread(){
        let netwoker = WTHotDiscussWorker()
        netwoker.fetchThreadResponse((self.thread?.thread)!) { [weak self](result) -> Void in
            if let sSelf = self {
                
                sSelf.thread?.moreResponse = result
//                sSelf.responseTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        responseTableView.registerNib(UINib(nibName: "WTDetailResponseCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kWTDetailResponseCellIdentifier)
        
        responseTableView.rowHeight = UITableViewAutomaticDimension
        responseTableView.estimatedRowHeight = 600
        
        self.setTabBarVisible(false, animated: false)
        setNavigationBackItem()
    }
    func setNavigationBackItem(){
        let image = UIImage(named: "ic_back")!.imageWithRenderingMode(.AlwaysOriginal)
        let backItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: "backToPreviousVC")
        self.navigationItem.leftBarButtonItem = backItem
    }
    func backToPreviousVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    override func viewWillDisappear(animated: Bool) {
        self.setTabBarVisible(true, animated: false)
    }

    func setTabBarVisible(visible:Bool, animated:Bool) {
        // get a frame calculation ready
        
        if (tabBarIsVisible() == visible) { return }
        
        let frame = self.tabBarController?.tabBar.frame
        let height = (frame?.size.height)! + 30
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
            }
        }
    }
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTDetailResponseCellIdentifier)
        setCellData(&cell!, indexPath: indexPath)
        return calculateHeight(cell!)

    }
    
    func setCellData(inout cell:UITableViewCell, indexPath: NSIndexPath){
        if let t = thread {
            print ("before:\(cell.frame.size.height)")
            let response = t.moreResponse[indexPath.row]
            (cell as! WTDetailResponseCell).setData(response)
            (cell as! WTDetailResponseCell).name.text = response.name
            (cell as! WTDetailResponseCell).response.text = response.response            
            print ("after:\(cell.frame.size.height)")
        }
    }
    
    func calculateHeight(cell:UITableViewCell) -> CGFloat {
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell.frame.size.height
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let t = thread {
            return t.moreResponse.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let t = thread {
            var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTDetailResponseCellIdentifier)
            
            if cell == nil{
                cell = WTDetailResponseCell()
            }
            
            let response = t.moreResponse[indexPath.row]
            
            (cell as! WTDetailResponseCell).setData(response)
            
            return cell!
        } else {
            
            return WTDetailResponseCell()
        }

    }
    
    
}