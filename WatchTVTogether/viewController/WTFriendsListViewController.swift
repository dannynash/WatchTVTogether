//
//  WTFriendsListViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFriendsListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    let dataSource = WTFriendsDataSource.sharedInstance
    
    override func viewDidLoad() {
        friendsTableView.registerNib(UINib(nibName: "WTFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kFriendCellIdentifier)

        friendsTableView.dataSource = dataSource
        friendsTableView.delegate = self
        friendsTableView.rowHeight = 85
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == WTSegue.kFriendsToChat{
            let friend = sender as! WTFriend
            let pageSize = 50
            let dataSource = WTChatMessageDataSource(messages: [], pageSize: pageSize, peerId: friend.userId)
            
            let chatController = segue.destinationViewController as! WTChatViewController
            chatController.dataSource = dataSource
            chatController.messageSender = dataSource.messageSender
            chatController.friend = friend
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let user = dataSource.friends[indexPath.row]
        self.performSegueWithIdentifier(WTSegue.kFriendsToChat, sender: user)
    }
    
}