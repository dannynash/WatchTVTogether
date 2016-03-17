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
    
    var program:WTProgram?
    
    var friends = Array<WTFriend>(){
        didSet{
//            friendsTableView.reloadData()
        }
    }
    var hotDiscusses = Array<WTHotDiscuss>(){
        didSet{
            hotDiscussTableView.reloadData()
        }
    }
    
    @IBOutlet weak var picturceView: UIImageView!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var hotDiscussTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    func setProgramUI(program:WTProgram){
        let programName = program.programName
        self.navigationTitle.title = programName

        if let pic = program.picture{
            self.picturceView.image = pic
        }
    }
    
    func setFriendsTable(program:WTProgram){
        let friendsDataSource = WTFriendsDataSource.sharedInstance
        let programId = program.programId
        
        friends = friendsDataSource.friendsWithProgram(programId)
    }
    
    func setHotDiscussTable(program:WTProgram){
        // TODO: show loading ui
        WTHotDiscussWorker().fetchHotDiscuss(program) { (result) -> Void in
            self.hotDiscusses = result
        }
    }
    
    override func viewDidLoad() {
        friendsTableView.registerNib(UINib(nibName: "WTFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kFriendCellIdentifier)
        
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        friendsTableView.separatorStyle = .None
        
        hotDiscussTableView.dataSource = self
        hotDiscussTableView.delegate = self
        hotDiscussTableView.separatorStyle = .None

        setProgramUI(program!)
        setFriendsTable(program!)
        setHotDiscussTable(program!)
        
        navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WTSegue.kProgramToChat{
            let friend = sender as! WTFriend
            let pageSize = 50
            let dataSource = WTChatMessageDataSource(messages: [], pageSize: pageSize, peerId: friend.userId)
            let chatController = segue.destinationViewController as! WTChatViewController
            
            chatController.friend = friend
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
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createTableHeader(tableView)
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
    
    func createTableHeader(tableView: UITableView)-> UIView?{
        let frame = CGRectMake(0, 0, tableView.frame.width, 20.0)
        let view = UIView(frame: frame)
        let label = UILabel(frame: CGRectMake(8.0, 8.0, tableView.frame.width, 12.0))
        
        if tableView == friendsTableView{
            label.text = NSLocalizedString("Friends", comment: "")
        } else if tableView == hotDiscussTableView{
            label.text = NSLocalizedString("Thread", comment: "")
        } else {
            return nil
        }

        view.addSubview(label)
        
        return view
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

