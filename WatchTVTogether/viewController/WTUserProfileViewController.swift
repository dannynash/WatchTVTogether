//
//  WTUserProfileViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTUserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var responses = Array<WTResponse>()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        let response1 = WTResponse(name: "danny", response: "shortResponse")
        let response2 = WTResponse(name: "danny", response: "longResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponse")
        
        responses.append(response1)
        responses.append(response2)
        
        tableview.registerNib(UINib(nibName: "WTFlexibleCell", bundle: nil), forCellReuseIdentifier: "WTFlexibleCell")
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 600
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let phoneNum = "tel://0933123456"
        UIApplication.sharedApplication().openURL(NSURL(string: phoneNum)!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WTFlexibleCell")
        
        if cell == nil{
            cell = WTFlexibleCell()
        }
        
        let response = responses[
            indexPath.row]
        
        (cell as! WTFlexibleCell).setData(response)

        return cell!
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
    }
}