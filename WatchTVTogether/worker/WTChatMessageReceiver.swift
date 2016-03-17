//
//  WTChatMessageReceiver.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/17.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

public class WTChatMessageReceiver{
    let channel = WTSocketIOClient.sharedInstance

    public var onMessage: ((message: String) -> Void)?

    init(){
        channel.onChatMessage = { [weak self] (message) in
            guard let sSelf = self else { return }
            let text = message["text"] as! String
            sSelf.notifyMessageChanged(text)
        }
    }
    
    private func notifyMessageChanged(message: String) {
        self.onMessage?(message: message)
    }

}