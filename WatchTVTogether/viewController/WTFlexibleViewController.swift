//
//  WTFlexibleViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/24.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFlexibleViewController:UIViewController, UITableViewDataSource {
    var responses = [WTResponse]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        let response1 = WTResponse(name: "danny", response: "shortResponse")
        let response2 = WTResponse(name: "danny", response: "longResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponse")
        
        responses.append(response1)
        responses.append(response2)
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 83
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WTFlexible1")
        
        if cell == nil{
            cell = WTFlexibleCell1()
        }
        
        let response = responses[
            indexPath.row]
        
        (cell as! WTFlexibleCell1).setData(response)
        
        return cell!
    }
    
    
    
}