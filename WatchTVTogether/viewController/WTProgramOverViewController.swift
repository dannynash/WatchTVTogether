//
//  WTProgramOverViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTProgramOverViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var program:WTProgram?{
        didSet {
            guard let wrappedProgram = program else {
                return
            }
            
            let friendsDataSource = WTFriendsDataSource.sharedInstance
            friends = friendsDataSource.friendsWithProgram(wrappedProgram.programId)!
        }
        
    }
    var friends = Array<WTFriend>(){
        didSet{
            friendsTableView.reloadData()
        }
    }
    var hotDiscusses = Array<WTHostDiscuss>()
    
    @IBOutlet weak var picturceView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var hotDiscussTableView: UITableView!
    
    override func viewDidLoad() {
        friendsTableView.registerNib(UINib(nibName: "WTFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kFriendCellIdentifier)
        
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WTSegue.kProgramToChat{
            let vc = segue.destinationViewController as! WTChatViewController
            let friend = sender as! WTFriend
            vc.friend = friend
            
            let pageSize = 50
            let dataSource = WTChatMessageDataSource(messages: [], pageSize: pageSize)

            let chatController = segue.destinationViewController as! WTChatViewController

            chatController.dataSource = dataSource
            chatController.messageSender = dataSource.messageSender
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        if tableView == friendsTableView{
            let friend = friends[indexPath.row]
            self.performSegueWithIdentifier(WTSegue.kProgramToChat, sender: friend)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendsTableView{
            return friends.count
        } else if tableView == hotDiscussTableView{
            return hotDiscusses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == friendsTableView{
            return createFriendCell(tableView, cellForRowAtIndexPath: indexPath)
        } else if tableView == hotDiscussTableView{
            return createHotDiscussCell(tableView, cellForRowAtIndexPath: indexPath)
        } else {
            return UITableViewCell()
        }

    }
    
    func createFriendCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kFriendCellIdentifier)
        
        if cell == nil{
            cell = WTFriendsTableViewCell()
        }
        
        (cell as! WTFriendsTableViewCell).setFriend(friends[indexPath.row])
        
        return cell!
    }
    func createHotDiscussCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO
        var cell = tableView.dequeueReusableCellWithIdentifier(WTNibIdentifier.kHotDiscussCellIdentifier)
        
        if cell == nil{
            cell = WTFriendsTableViewCell()
        }
        
        (cell as! WTFriendsTableViewCell).setFriend(friends[indexPath.row])
        
        return cell!
    }

}