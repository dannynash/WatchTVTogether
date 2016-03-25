//
//  WTProgramOverViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTProgramOverViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var program:WTProgram?
    
    var friends = Array<WTFriend>(){
        didSet{
//            friendsTableView.reloadData()
        }
    }
    var hotDiscusses = Array<WTThread>(){
        didSet{
            threadDataSource.threads = hotDiscusses
            hotDiscussTableView.reloadData()
        }
    }
    
    @IBOutlet weak var picturceView: UIImageView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var hotDiscussTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    func setProgramUI(program:WTProgram){
        let programName = program.programName
        self.navigationTitle.title = programName

        if let pic = program.pictureUrl{
            self.setImage(pic)
        }
    }
    
    private func setImage(pictureUrl:String){
        WTImageProxy().fetchImage(pictureUrl) { [weak self](result) -> Void in
            
            guard let sSelf = self else {
                return
            }
            sSelf.picturceView.image = result
        }
    }

    func setFriendsTable(program:WTProgram){
        let friendsDataSource = WTFriendsDataSource.sharedInstance
        let programId = program.programId
        
        friends = friendsDataSource.friendsWithProgram(programId)
    }
    
    func setHotDiscussTable(program:WTProgram){
        // TODO: show loading ui
        WTHotDiscussWorker().fetchHotDiscuss(program) { [weak self](result) -> Void in
            guard let sSelf = self else {
                return
            }

            sSelf.threadDataSource.threads = result
            sSelf.hotDiscussTableView.reloadData()
        }
    }
    
    let threadDataSource = WTThreadDataSource()

    override func viewDidLoad() {
        friendsCollectionView.registerNib(UINib(nibName: "WTFriendCollectionCell", bundle: nil), forCellWithReuseIdentifier: WTNibIdentifier.kFriendCollectionCellIdentifier)
        
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        
        hotDiscussTableView.registerNib(UINib(nibName: "WTTheadTitleCell", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kWTThreadTitleCellIdentifier)
        hotDiscussTableView.registerNib(UINib(nibName: "WTResponseView", bundle: nil), forCellReuseIdentifier: WTNibIdentifier.kWTResponseViewIdentifier)
        
        hotDiscussTableView.dataSource = threadDataSource
        hotDiscussTableView.delegate = self
        hotDiscussTableView.separatorStyle = .None

        setProgramUI(program!)
        setFriendsTable(program!)
        setHotDiscussTable(program!)

        setNavigationBackItem()
    }
    func setNavigationBackItem(){
        let image = UIImage(named: "ic_back")!.imageWithRenderingMode(.AlwaysOriginal)
        let backItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: "backToPreviousVC")
        self.navigationItem.leftBarButtonItem = backItem
    }
    func backToPreviousVC(){
        self.navigationController?.popViewControllerAnimated(true)
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
            
        } else if segue.identifier == WTSegue.kProgramToThread{
            let vc = segue.destinationViewController as! WTDetailThreadViewController
            
            guard touchedThread != nil else {
                return
            }
            vc.setThread(WTDetailThread(thread: touchedThread!))
        }
    }
    
    var touchedThread:WTThread?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        if tableView == hotDiscussTableView{
            touchedThread = threadDataSource.threads[indexPath.section]
            self.performSegueWithIdentifier(WTSegue.kProgramToThread, sender: nil)
        }
    }
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return createTableHeader(tableView)
//    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hotDiscussTableView{
            return hotDiscusses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == hotDiscussTableView{
            return createHotDiscussCell(tableView, cellForRowAtIndexPath: indexPath)
        } else {
            return UITableViewCell()
        }

    }
    
    func createTableHeader(tableView: UITableView)-> UIView?{
        let frame = CGRectMake(0, 0, tableView.frame.width, 20.0)
        let view = UIView(frame: frame)
        let label = UILabel(frame: CGRectMake(8.0, 8.0, tableView.frame.width, 12.0))
        
        if tableView == hotDiscussTableView{
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
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WTNibIdentifier.kFriendCollectionCellIdentifier, forIndexPath: indexPath)
        
        (cell as! WTFriendCollectionCell).setFriend(friends[indexPath.row])

        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
        let friend = friends[indexPath.row]
        self.performSegueWithIdentifier(WTSegue.kProgramToChat, sender: friend)
    }
    
}

