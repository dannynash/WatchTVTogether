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
        let programs = ["春風望露", "一把青", "中華職棒"]
        
        let friend1 = WTFriend(userId: "1", userName: "Danny", userStatus: .online, programId: "1", pictureUrl:"profile_01.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend2 = WTFriend(userId: "2", userName: "Ken", userStatus: .online, programId: "1", pictureUrl:"profile_02.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend3 = WTFriend(userId: "3", userName: "Amber", userStatus: .online, programId: "1", pictureUrl:"profile_03.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend4 = WTFriend(userId: "4", userName: "Frankie", userStatus: .online, programId: "1", pictureUrl:"profile_04.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend5 = WTFriend(userId: "5", userName: "Sean", userStatus: .online, programId: "1", pictureUrl:"profile_05.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend6 = WTFriend(userId: "6", userName: "Annie", userStatus: .online, programId: "1", pictureUrl:"profile_06.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend7 = WTFriend(userId: "7", userName: "Joan", userStatus: .online, programId: "1", pictureUrl:"profile_07.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend8 = WTFriend(userId: "8", userName: "Lisa", userStatus: .online, programId: "1", pictureUrl:"profile_08.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend9 = WTFriend(userId: "9", userName: "Eric", userStatus: .online, programId: "1", pictureUrl:"profile_09.png", programName:programs[Int(arc4random_uniform(100)%3)])
        let friend10 = WTFriend(userId: "10", userName: "Vivian", userStatus: .online, programId: "1", pictureUrl:"profile_10.png", programName:programs[Int(arc4random_uniform(100)%3)])
        
        friends.append(friend1)
        friends.append(friend2)
        friends.append(friend3)
        friends.append(friend4)
        friends.append(friend5)
        friends.append(friend6)
        friends.append(friend7)
        friends.append(friend8)
        friends.append(friend9)
        friends.append(friend10)
    }
    
    func friendsWithProgram(programId:String) -> Array<WTFriend> {
        return collectFriendsWithProgram(programId)
    }
    
    func collectFriendsWithProgram(programId:String) -> Array<WTFriend>{
        var friendsWithSameProgram = Array<WTFriend>()
        
        for friend in friends {
//            if friend.programId == programId{
//                friendsWithSameProgram.append(friend)
//            }
            
            if Int(arc4random_uniform(100)%3) == 0{
                friendsWithSameProgram.append(friend)
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