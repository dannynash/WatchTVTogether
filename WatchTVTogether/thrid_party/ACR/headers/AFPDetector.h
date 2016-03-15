//
//  AFPDetector.h
//  AFPDetectLibrary
//
//  Created by Ulyness Chen on 4/9/15.
//  Copyright (c) 2015 III_SNSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFPDetectorDelegate <NSObject>
@optional
//! @brief 用來接收結果。接收的內容參考隨附說明文件
- (void)afpDetectionResult:(NSDictionary *)results error:(NSError *)error;
//! @brief 被呼叫時表示可以刪除AFP Object了
- (void)readyToDeleteAFPObject;
//! @brief 被呼叫表示可以開始進行偵測
- (void)readyToDetect:(BOOL)isReady error:(NSError *)error;
@end

/**
 * @brief 以上傳AFP的方式比對頻道。由Server告知哪個頻道最接近＆分數多少（最多100）。結果以delegate的方式通知
 */
@interface AFPDetector : NSObject
/**
 @brief 頻道偵測的初始化
 @param delegate 接收結果用的delegate
 @param APIKey 認證用的API Key
 @return 本class的object
 */
- (id)initChannelDetectWithDelegate:(NSObject<AFPDetectorDelegate> *)delegate APIKey:(NSString *)APIKey;

/**
 @brief 片段辨識的初始化
 @param delegate 接收結果用的delegate
 @param APIKey 認證用的API Key
 @return 本class的object
 */
- (id)initVODDetectRemotelyWithDelegate:(NSObject<AFPDetectorDelegate> *)delegate APIKey:(NSString *)APIKey;

/**
 @brief 片段辨識的初始化
 @param userName 使用者名稱
 @param delegate 接收結果用的delegate
 @param APIKey 認證用的API Key
 @return 本class的object
 */
- (id)initVODDetectWithUserName:(NSString *)userName delegate:(NSObject<AFPDetectorDelegate> *)delegate AFPKey:(NSString *)APIKey;

//! @brief 開始錄音與偵測。停止偵測條件：偵測到結果（分數超過75以上）或是超過一定長度（15秒），或是途中另外呼叫"stopDetect"。送出偵測結果：在超過分數或是超過長度導致偵測完時送出，一次
- (void)startDetect;

//! @brief 開始錄音跟偵測。停止偵測條件：達到該秒數並且進行完偵測動作後，或者途中另外呼叫"stopDetect"。送出偵測結果：偵測完後送出，只送一次
- (void)startDetectUntil:(int)seconds;

//! @brief 結束錄音與偵測。注意：偵測不會立刻停止，當偵測完全停止時會呼叫delegate的"readyToDeleteAFPObject"，請在那之後再刪除此object。注意：因為是中途結束，所以不會取得偵測分數
- (void)stopDetect;

//! @brief 偵測機器的Performance是否足夠。回傳BOOL代表「是否」足夠。注意這並不是個立刻回傳的method，需要0~1秒時間來執行，保險起見請放在額外的thread或平行處理
- (BOOL)testPerformance;

//! @brief 本Library的版本編號
+ (NSString *)ver;

//! @brief 是否顯示各種細部log
+ (void)showAllLog:(BOOL)shouldShow;

//! @brief 設定是否要啟動錄音功能
+ (void)enableRecording:(BOOL)on;
//! @brief 確認是否啟動了錄音功能
+ (BOOL)isRecordingEnabled;

@end
