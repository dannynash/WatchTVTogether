//
//  WTSocketIOClient.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/10.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import SocketIOClientSwift
import SwiftyJSON

public final class WTSocketIOClient{
    static let sharedInstance = WTSocketIOClient()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://172.22.3.108:3000")!, options: [.Log(true), .ForcePolling(true)])
    
    var currentUserId:String
    
    init(){
        //TODO
        currentUserId = ""
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                self.socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
                    self.socket.emit("update", ["amount": cur + 2.50])
                }
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.on("chat") {[weak self]data, ack in
            
            guard let sSelf = self else { return }

            sSelf.onChatMessage!(message: data)
            print("on chat message", data);
        }

        socket.connect()
    }

    public func emit(event: String, _ items: AnyObject...) {
        socket.emit(event, items)
    }
    
    public var onChatMessage: ((message: AnyObject) -> Void)?

}
