//
//  GameViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko Nagaishi on 2021/02/26.
//

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
    
    var imageName: String = "bubble"
    
    var tapiArray = ["bubble1", "bubble2", "bubble3", "bubble4", "bubble5", "bubble6", "bubble7", "bubble8", "bubble9", "bubble10"]
    
    var timeCount: Int = 60
    var timer: Timer!
    
    let motionManager = CMMotionManager()
    
    var accelerationX: Double = 0.0
    var accelerationY: Double = 0.0
    var accelerationZ: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for bubble1. tapiokanokazubunndake,hairetunonakanoua
        
        //for tapiArray[]
//
        for i in 0...10 {

            bubbleMove(bubbleImageView: )
        }
//
        //↑for文にすることでbubble1234...って自動にやってくれる
        
        bubbleMove(bubbleImageView: bubble1)
        bubbleMove2(bubbleImageView: bubble2)
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
//        print("\(timeCount)")
        timerLabel.text = String(timeCount)
    
        //self.performSegue(withIdentifier: "toResult", sender: nil)
        bubbleMove(bubbleImageView: bubble1)
        bubbleMove2(bubbleImageView: bubble2)
    }
    
    
    func bubbleMove(bubbleImageView: UIImageView){
        var place:Float!
        if motionManager.isAccelerometerAvailable {
            //intervalの設定（sec）
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                bubbleImageView.center.x += CGFloat(self.accelerationX*20)
                bubbleImageView.center.y +=
                    CGFloat(self.accelerationY*20)
                place = Float(bubbleImageView.center.x)
                 print(Float(bubbleImageView.center.x))
                
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
    func bubbleMove2(bubbleImageView: UIImageView) {
        if motionManager.isAccelerometerAvailable {
            //intervalの設定（sec）
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                bubbleImageView.center.x += CGFloat(self.accelerationX*20)
                bubbleImageView.center.y +=
                    CGFloat(self.accelerationY*20)
                print(Float(bubbleImageView.center.x))
                
                
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
    
}

