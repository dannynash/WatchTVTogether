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
    
    @IBOutlet weak var icon: UIImageView!
//    var afpdetector: AFPDetector?
//    var timerClock:NSTimer?
//    var dateStartDetect:NSDate?
//    
//    @IBOutlet weak var labelClock: UILabel!
//    @IBOutlet weak var resultLabel: UILabel!
//    @IBOutlet weak var buttonDetect: UIButton!
//    
//    @IBAction func startDetect(sender: AnyObject) {
//        afpdetector?.startDetect()
//        
//        dateStartDetect = NSDate()
//        timerClock = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateClock", userInfo: nil, repeats: true)
//        
//    }
// 
//    @IBAction func stopDetect(sender: AnyObject) {
//        afpdetector?.stopDetect()
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        let icon = UIImage(named: "ic_icon.png")
//        icon?.imageWithRenderingMode(.AlwaysOriginal)
//        self.tabBarItem.image! = icon!
//        
//    }
    
    var timer:NSTimer?

    @IBAction func tabCancel(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setTabBarVisible(false, animated: false)
        self.icon.alpha = 1.0
        UIView.animateWithDuration(1, delay: 0.0, options: [.CurveEaseInOut, .Repeat, .Autoreverse, .AllowUserInteraction], animations: {() -> Void in
            self.icon.alpha = 0.0
            }, completion: {(finished: Bool) -> Void in
        })

        if timer == nil{
            timer = NSTimer(timeInterval: NSTimeInterval(3), target: self, selector: "enterRoom", userInfo: nil, repeats: false)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        self.setTabBarVisible(true, animated: false)
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
    }

    func enterRoom(){
        self.performSegueWithIdentifier(WTSegue.kSearchToPost, sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WTSegue.kSearchToPost{
//            let post = dataSource.posts[indexPath.section]
            let programVC = segue.destinationViewController as! WTProgramOverViewController
            let post = WTFakeTmpStorage.shareInstance.post!
            programVC.program = post.program

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        // get a frame calculation ready
        
        if (tabBarIsVisible() == visible) { return }
        
        let frame = self.tabBarController?.tabBar.frame
        let height = (frame?.size.height)! + 30
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
            }
        }
    }
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }

//
//    func updateClock(){
//        let second = NSDate.timeIntervalSinceDate(dateStartDetect!)
//        labelClock.text = "\(second)"
//    }
//    
//    // MARK: - AFPDetectorDelegate
//    func afpDetectionResult(results: [NSObject : AnyObject]!, error: NSError!) {
//        timerClock?.invalidate()
//        timerClock = nil
//        
//        guard let unwrappedName = results else {
//            return
//        }
//        
//        resultLabel.text = unwrappedName["score"] as? String
//    }
//    
//    func readyToDeleteAFPObject() {
//        if timerClock != nil {
//            timerClock?.invalidate()
//            timerClock = nil
//        }
//        
//        afpdetector = nil
//        
//        let manager = AFPUploadManager.init(APIKey: kAPIKey, uploadCompletedHandler: nil)
//        print("upload list: \(manager.getRecordList())")
//    }
//    
//    func readyToDetect(isReady: Bool, error: NSError!) {
//        if isReady == true{
//            buttonDetect.enabled = true
//            
//        } else {
//            dispatch_async(dispatch_get_main_queue(), { [weak self] in
//                
//                let vc = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
//                guard let sSelf = self else { return }
//                sSelf.presentViewController(vc, animated: false, completion: { () -> Void in
//
//                })
//            })
//            afpdetector = nil
//        }
//        
//    }
    
}