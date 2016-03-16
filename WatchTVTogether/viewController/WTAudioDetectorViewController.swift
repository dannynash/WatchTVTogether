//
//  WTAudioDetectorViewController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/14.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTAudioDetectorViewController: UIViewController, AFPDetectorDelegate{
    
    var afpdetector: AFPDetector?
    var timerClock:NSTimer?
    var dateStartDetect:NSDate?
    
    @IBOutlet weak var labelClock: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var buttonDetect: UIButton!
    
    @IBAction func startDetect(sender: AnyObject) {
        afpdetector?.startDetect()
        
        dateStartDetect = NSDate()
        timerClock = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateClock", userInfo: nil, repeats: true)
        
    }
 
    @IBAction func stopDetect(sender: AnyObject) {
        afpdetector?.stopDetect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        afpdetector = AFPDetector.init(channelDetectWithDelegate: self, APIKey: kAPIKey)
        
        guard afpdetector != nil else{
            let vc = UIAlertController.init(title: "Init failed", message: "Init failed", preferredStyle: .Alert)
            presentViewController(vc, animated: false, completion: { () -> Void in
                
            })
            return
        }

    }
    
    func updateClock(){
        let second = NSDate.timeIntervalSinceDate(dateStartDetect!)
        labelClock.text = "\(second)"
    }
    
    // MARK: - AFPDetectorDelegate
    func afpDetectionResult(results: [NSObject : AnyObject]!, error: NSError!) {
        timerClock?.invalidate()
        timerClock = nil
        
        guard let unwrappedName = results else {
            return
        }
        
        resultLabel.text = unwrappedName["score"] as? String
    }
    
    func readyToDeleteAFPObject() {
        if timerClock != nil {
            timerClock?.invalidate()
            timerClock = nil
        }
        
        afpdetector = nil
        
        let manager = AFPUploadManager.init(APIKey: kAPIKey, uploadCompletedHandler: nil)
        print("upload list: \(manager.getRecordList())")
    }
    
    func readyToDetect(isReady: Bool, error: NSError!) {
        if isReady == true{
            buttonDetect.enabled = true
            
        } else {
            dispatch_async(dispatch_get_main_queue(), { [weak self] in
                
                let vc = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                guard let sSelf = self else { return }
                sSelf.presentViewController(vc, animated: false, completion: { () -> Void in

                })
            })
            afpdetector = nil
        }
        
    }
    
}