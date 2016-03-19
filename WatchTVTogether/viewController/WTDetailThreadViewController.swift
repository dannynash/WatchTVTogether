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
        netwoker.fetchThreadResponse((self.thread?.thread)!) { (result) -> Void in
            self.thread?.moreResponse = result
        }
    }
    
    override func viewDidLoad() {
        responseTableView.registerNib(UINib(nibName: "WTDetailResponseCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kWTDetailResponseCellIdentifier)
        
        responseTableView.rowHeight = UITableViewAutomaticDimension
        responseTableView.estimatedRowHeight = 160.0

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTDetailResponseCellIdentifier)
        setCellData(&cell!, heightForRowAtIndexPath: indexPath)
        return calculateHeight(cell!)

    }
    
    func setCellData(inout cell:UITableViewCell, heightForRowAtIndexPath indexPath: NSIndexPath){
        if let t = thread {
            let response = t.moreResponse[indexPath.row]
            (cell as! WTDetailResponseCell).setData(response)
        }
    }
    
    func calculateHeight(cell:UITableViewCell) -> CGFloat {
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