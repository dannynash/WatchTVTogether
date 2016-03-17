//
//  WTChatUserActionHandlers.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/11.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class WTTextMessageHandler: BaseMessageInteractionHandlerProtocol {
    private let baseHandler: WTBaseMessageHandler
    init (baseHandler: WTBaseMessageHandler) {
        self.baseHandler = baseHandler
    }
    func userDidTapOnFailIcon(viewModel viewModel: TextMessageViewModel) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }
    
    func userDidTapOnBubble(viewModel viewModel: TextMessageViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }
    
    func userDidLongPressOnBubble(viewModel viewModel: TextMessageViewModel) {
        self.baseHandler.userDidLongPressOnBubble(viewModel: viewModel)
    }
}

class WTPhotoMessageHandler: BaseMessageInteractionHandlerProtocol {
    private let baseHandler: WTBaseMessageHandler
    init (baseHandler: WTBaseMessageHandler) {
        self.baseHandler = baseHandler
    }
    
    func userDidTapOnFailIcon(viewModel viewModel: PhotoMessageViewModel) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }
    
    func userDidTapOnBubble(viewModel viewModel: PhotoMessageViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }
    
    func userDidLongPressOnBubble(viewModel viewModel: PhotoMessageViewModel) {
        self.baseHandler.userDidLongPressOnBubble(viewModel: viewModel)
    }
}

class WTBaseMessageHandler {
    
    private let messageSender: WTChatMessageSender
    init (messageSender: WTChatMessageSender) {
        self.messageSender = messageSender
    }
    func userDidTapOnFailIcon(viewModel viewModel: MessageViewModelProtocol) {
        NSLog("userDidTapOnFailIcon")
//        self.messageSender.sendTextMessage(viewModel.messageModel)
    }
    
    func userDidTapOnBubble(viewModel viewModel: MessageViewModelProtocol) {
        NSLog("userDidTapOnBubble")
        
    }
    
    func userDidLongPressOnBubble(viewModel viewModel: MessageViewModelProtocol) {
        NSLog("userDidLongPressOnBubble")
    }
}
