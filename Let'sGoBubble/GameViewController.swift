//
//  GameViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko Nagaishi on 2021/02/26.
//

import AVFoundation
import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    @IBOutlet var bubble1: UIImageView!
    @IBOutlet var bubble2: UIImageView!
    @IBOutlet var bubble3: UIImageView!
    @IBOutlet var bubble4: UIImageView!
    @IBOutlet var bubble5: UIImageView!
    @IBOutlet var bubble6: UIImageView!
    @IBOutlet var bubble7: UIImageView!
    @IBOutlet var bubble8: UIImageView!
    @IBOutlet var bubble9: UIImageView!
    @IBOutlet var bubble10: UIImageView!
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    let motionManager = CMMotionManager()
    
    var accelerationX: Double = 0.0
    var accelerationY: Double = 0.0
    var accelerationZ: Double = 0.0
    var velocityY: Double = 0.0
    
    
    var bubbleArray = [UIImageView]()
    
    var audioPlayer: AVAudioPlayer!
    
    var timeCount: Int = 60
    var timer: Timer!
    
    var score: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleArray = [bubble1, bubble2, bubble3, bubble4, bubble5, bubble6, bubble7, bubble8, bubble9, bubble10]
        
        bubbleMove(bubbles: bubbleArray)
        
        
        //timerの設定
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true)
    }
    
    //1秒ごとにタイマーラベル更新
    @objc func countDown() {
        
        timeCount = timeCount - 1
        timerLabel.text = String(timeCount)
        
//        for bubbleImageView in bubbles{
            
        //background切り替え
        if timeCount <= 0 {
            backgroundImageView.image = UIImage(named: "bg_0")
            RunLoop.current.run(until:Date.init(timeIntervalSinceNow: 3.0))
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }else if timeCount <= 15{
            backgroundImageView.image = UIImage(named: "bg_15")
        }else if timeCount <= 30{
            backgroundImageView.image = UIImage(named: "bg_30")
        }else if timeCount <= 45{
            backgroundImageView.image = UIImage(named: "bg_45")
            
        }
    }
    
    
    func bubbleMove(bubbles: [UIImageView]){
        
        if motionManager.isAccelerometerAvailable {
            //intervalの設定（sec）
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                self.accelerationZ = (data?.acceleration.z)!
                
                for bubbleImageView in bubbles{
                    
                    bubbleImageView.center.x += CGFloat(self.accelerationX*20)
                    bubbleImageView.center.y += CGFloat(self.accelerationY*20)
                    
                    //座標の制限
                    if bubbleImageView.frame.origin.x < 0 {
                        bubbleImageView.frame.origin.x = 0
                    }
                    if bubbleImageView.frame.origin.x > 300 {
                        bubbleImageView.frame.origin.x = 300
                    }
                    if bubbleImageView.frame.origin.y < 45 {
                        bubbleImageView.frame.origin.y = 45
                    }
                    
                    if bubbleImageView.frame.origin.y > 700 {
                        bubbleImageView.frame.origin.y = 700
                    }
                }
            }
        }
        
    
        func scoreUpdate(bubbles: [UIImageView]){
        }
    }
}

