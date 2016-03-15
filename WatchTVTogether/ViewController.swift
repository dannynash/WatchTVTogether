//
//  ViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/10.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import UIKit

struct ViewControllerIdentifier {
    static let kGotoChat = "aqi5cr5flucx9woo1j29ia78z330oe3nz39jmp7b"
    static let kGotoDetect = "ideastest"
}

class ViewController: UIViewController {

//    var channel = WTSocketIOClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSendMessage(sender: AnyObject) {
//        channel.emit("chat message", "message testing")
    }
    @IBAction func sendJson(sender: AnyObject) {
//        channel.emit("chat message", ["abc":123])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ViewControllerIdentifier.kGotoChat {
            let pageSize = 50
            let dataSource = WTChatMessageDataSource(messages: [], pageSize: pageSize)
            
            let chatController = segue.destinationViewController as! WTChatViewController
            
            chatController.dataSource = dataSource
            chatController.messageSender = dataSource.messageSender
            
        } else if segue.identifier == ViewControllerIdentifier.kGotoDetect {
        
        }
    }
    
}

