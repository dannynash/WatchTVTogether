//
//  WTPostsDataSource.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/16.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTPostsDataSource:NSObject, UITableViewDataSource {
    
    var posts = Array<WTPost>()
    
    override init(){
        super.init()
        
        createFakeData()
    }
    
    func createFakeData(){

//        let post1 = WTPost(programId:"1", programTitle: "NBA 勇士 v.s. 小牛", channelTitle: "ESPN", responseNums: "356", lastResponse: [WTResponse(name: "danny", response: "食神實在太棒啦" ),WTResponse(name: "danny", response: "食神實在太棒啦"),WTResponse(name: "danny", response: "食神實在太棒啦食神實在太棒啦食神實在太棒啦食神實在太棒啦食神實在太棒啦")], lastUpdateTime: "5分鐘前", picture: UIImage(named: "photo.jpeg"))
//        posts.append(post1)
//        let post2 = WTPost(programId:"2", programTitle: "正晶限時批", channelTitle: "壹電視", responseNums: "3156", lastResponse: [WTResponse(name: "danny", response: "限時批政經")], lastUpdateTime: "1分鐘前", picture: UIImage(named: "maxresdefault.jpg"))
//        posts.append(post2)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[section].lastResponse.count + 1 // image
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            return createImageCell(tableView, cellForRowAtIndexPath: indexPath)
        } else {
            return createResponseCell(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    
    func createImageCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kPostCellIdentifier)
        
        if cell == nil{
            cell = WTPostTableViewCell()
        }
        
        (cell as! WTPostTableViewCell).setPost(posts[indexPath.section], rank: indexPath.row+1)
        return cell!
        
    }
    
    func createResponseCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kWTResponseViewIdentifier)
        
        if cell == nil{
            cell = WTResponseView()
        }
        
        let responses = posts[indexPath.section].lastResponse
        let response = responses[indexPath.row-1]
        
        (cell as! WTResponseView).setData(response.name, response: response.response)
        
        return cell!

    }
    
}

