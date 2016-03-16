//
//  WTFriendsDataSource.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/16.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFriendsDataSource:NSObject, UITableViewDataSource {
    static let sharedInstance = WTFriendsDataSource()

    var friends = Array<WTFriend>()
    
    override init() {
        super.init()
        createFakeData()
    }
    
    func createFakeData(){
        let friend1 = WTFriend(userId: "1", userName: "Danny", userStatus: .online, programId: "1")
        friends.append(friend1)
        let friend2 = WTFriend(userId: "2", userName: "Ken")
        friends.append(friend2)
    }
    
    func friendsWithProgram(programId:String) -> Array<WTFriend>? {
        return collectFriendsWithProgram(programId)
    }
    
    func collectFriendsWithProgram(programId:String) -> Array<WTFriend>?{
        var friendsWithSameProgram = Array<WTFriend>?()
        
        for friend in friends {
            if friend.programId == programId{
                friendsWithSameProgram?.append(friend)
            }
        }
        
        return friendsWithSameProgram
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kFriendCellIdentifier)

        if cell == nil{
            cell = WTFriendsTableViewCell()
        }

        (cell as! WTFriendsTableViewCell).setFriend(friends[indexPath.row])
        
        return cell!
    }
    
}