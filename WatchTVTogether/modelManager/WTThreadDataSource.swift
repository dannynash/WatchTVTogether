//
//  WTThreadDataSource.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTThreadDataSource: NSObject, UITableViewDataSource {
    
    var threads = Array<WTThread>()

    override init(){
        super.init()
        
        createFakeData()
    }

    func createFakeData(){
        let thread1 = WTThread(source: WTThreadSource.PTT, url: "", responseNum: 700, lastResponse: [WTResponse(name: "danny", response: "理性勿戰"), WTResponse(name: "danny", response: "理性勿戰")], lastUpdateTime: NSDate().timeIntervalSince1970/1000)
        
        let thread2 = WTThread(source: WTThreadSource.FB, url: "", responseNum: 700, lastResponse: [WTResponse(name: "danny", response: "賭神怎麼還不變身超級賽亞人")], lastUpdateTime: NSDate().timeIntervalSince1970/1000)
        
        threads.append(thread1)
        threads.append(thread2)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return threads.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads[section].lastResponse.count + 1 // image
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            return createTitleCell(tableView, cellForRowAtIndexPath: indexPath)
        } else {
            return createResponseCell(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    
    func createTitleCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTThreadTitleCellIdentifier)
        
        if cell == nil{
            cell = WTTheadTitleCell()
        }
        
        (cell as! WTTheadTitleCell).setData(threads[indexPath.section].source, responseNum: threads[indexPath.section].responseNum)

        return cell!
        
    }
    
    func createResponseCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTResponseViewIdentifier)
        
        if cell == nil{
            cell = WTResponseView()
        }
        
        let responses = threads[indexPath.section].lastResponse
        let response = responses[indexPath.row-1]
        
        (cell as! WTResponseView).setData(response.name, response: response.response)
        
        return cell!
        
    }

    


}