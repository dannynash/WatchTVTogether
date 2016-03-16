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
        let post1 = WTPost(programId:"1", programTitle: "NBA 勇士 v.s. 小牛", channelTitle: "ESPN", responseNums: "356則回應", lastResponse: "danny:食神實在太棒啦", lastUpdateTime: "5分鐘前", picture: UIImage(named: "photo.jpeg"))
        posts.append(post1)
        let post2 = WTPost(programId:"2", programTitle: "正晶", channelTitle: "壹電視", responseNums: "3156則回應", lastResponse: "danny:限時批政經", lastUpdateTime: "１分鐘前", picture: UIImage(named: "maxresdefault.jpg"))
        posts.append(post2)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kPostCellIdentifier)
        
        if cell == nil{
            cell = WTPostTableViewCell()
        }
        
        (cell as! WTPostTableViewCell).setPost(posts[indexPath.row])
        return cell!
    }
    
}

