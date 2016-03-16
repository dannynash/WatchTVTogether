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
    
    var programId:String?{
        didSet {
            guard let wrappedName = programId else {
                return
            }

            let friendsDataSource = WTFriendsDataSource.sharedInstance
            friends = friendsDataSource.friendsWithProgram(wrappedName)!
        }
        
    }
    var friends = Array<WTFriend>(){
        didSet{
            friendsTableView.reloadData()
        }
    }
    
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

        let friend = friends[indexPath.row]
        self.performSegueWithIdentifier(WTSegue.kProgramToChat, sender: friend)
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