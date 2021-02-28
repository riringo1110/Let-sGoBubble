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
    var count: Int = 0
    
    var bubbleArray = [UIImageView]()
    
    var audioPlayer: AVAudioPlayer!
    
    var timeCount: Int = 60
    var timer: Timer!
    
    var score: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleArray = [bubble1, bubble2, bubble3]
        
        for bubble in bubbleArray{
            bubbleMove(bubbleImageView: bubble)
        }
        
       
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
       
        //background切り替え
        if timeCount <= 45 {
            backgroundImageView.image = UIImage(named: "bg_45")
        }
        if timeCount <= 30{
            backgroundImageView.image = UIImage(named: "bg_30")
        }
        if timeCount <= 15{
            backgroundImageView.image = UIImage(named: "bg_15")
        }
        if timeCount == 0{
            backgroundImageView.image = UIImage(named: "bg_0")
        }
        if timeCount == 0{
            Thread.sleep(forTimeInterval: 3.0)
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }
        
        for bubble in bubbleArray{
            bubbleMove(bubbleImageView: bubble)
        }
    }
    
    
    func bubbleMove(bubbleImageView: UIImageView){
       
        if motionManager.isAccelerometerAvailable {
            //intervalの設定（sec）
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                self.accelerationZ = (data?.acceleration.z)!
                bubbleImageView.center.x += CGFloat(self.accelerationX*20)
                bubbleImageView.center.y += CGFloat(self.accelerationY*20)
                

                if bubbleImageView.frame.origin.x < 20 {
                    bubbleImageView.frame.origin.x = 20
                }
                
                if bubbleImageView.frame.origin.x > 300 {
                    bubbleImageView.frame.origin.x = 300
                }
                if bubbleImageView.frame.origin.y < 45 {
                    bubbleImageView.frame.origin.y = 45
                }
                
                if bubbleImageView.frame.origin.y > 770 {
                    bubbleImageView.frame.origin.y = 770
                }
            }
            
        }
        
    }
    
    
    
   
    
    
    
    func scoreUpdate(){
        
        
        
        
    }
}

