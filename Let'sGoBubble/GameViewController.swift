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
    
    
    var bubbleImageArray = [UIImageView]()
    //
    var bubbleArray = [Bubble]()
    
    //音楽再生のためのクラス
    let soundManager = SoundManager.shared
    
    var timeCount: Int = 60
    var timer: Timer!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert: UIAlertController = UIAlertController(
            title: "ARE YOU READY?",
            message: "スマホを水平にしてください",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
        present(alert,animated: true, completion: nil)
        
        bubbleImageArray = [bubble1, bubble2, bubble3, bubble4, bubble5, bubble6, bubble7, bubble8, bubble9, bubble10]
        
        for bubble in bubbleImageArray {
            let boba = Bubble(imageView: bubble)
            bubbleArray.append(boba)
        }
        
        
        bubbleMove()
        
        //timerの設定
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true)
        
    }
    
    //1秒ごとにタイマーラベル更新
    @objc func countDown() {
        
        timeCount = timeCount - 1
        timerLabel.text = String(timeCount)
        
        //            //background切り替え
                            if timeCount <= 0 {
//                                backgroundImageView.image = UIImage(named: "bg_0")
                                RunLoop.current.run(until:Date.init(timeIntervalSinceNow: 3.0))
                                self.performSegue(withIdentifier: "toResult", sender: nil)
        //                    }else if timeCount <= 15{
        //                        backgroundImageView.image = UIImage(named: "bg_15")
        //                    }else if timeCount <= 30{
        //                        backgroundImageView.image = UIImage(named: "bg_30")
        //                    }else if timeCount <= 45{
        //                        backgroundImageView.image = UIImage(named: "bg_45")
                            }
    }
    
    //画面が見えるようになる時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        super.viewWillAppear(animated)
        soundManager.playBGM(fileName: "higedance")
    }

    //画面が見えなくなるときに呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        soundManager.stopBGM()
    }

    func bubbleMove(){
        
        if motionManager.isAccelerometerAvailable {
            //intervalの設定
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                
                for i in 0..<self.bubbleArray.count {
                    let boba = self.bubbleArray[i]
                    let ransu = CGFloat.random(in: 1...10)
                    
                    boba.imageView.center.x += CGFloat(self.accelerationX * Double(ransu))
                    boba.imageView.center.y -= CGFloat(self.accelerationY * Double(ransu))
                    
                    boba.imageView.center.x += boba.vx
                    boba.imageView.center.y += boba.vy
                    
                    //画面端にいったらマイナス
                    if boba.imageView.frame.origin.x < 0 {
                        boba.imageView.frame.origin.x = 0
                        boba.vx = -boba.vx
                    }
                    
                    if boba.imageView.frame.origin.x > self.view.frame.width - boba.imageView.frame.width {
                        boba.imageView.frame.origin.x = self.view.frame.width - boba.imageView.frame.width
                        boba.vx = -boba.vx
                    }
                    
                    if boba.imageView.frame.origin.y < boba.imageView.frame.height * 3.5{
                        boba.imageView.frame.origin.y = boba.imageView.frame.height * 3.5
//                        //15秒毎に水位下がる
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                            
//                        }
                        
                        boba.vy = -boba.vy
                    }
                    
                    
                    if boba.imageView.frame.origin.y > self.view.frame.height - boba.imageView.frame.height {
                        boba.imageView.frame.origin.y = self.view.frame.height - boba.imageView.frame.height
                        boba.vy = -boba.vy
                    }
                    if boba.imageView.frame.origin.x == 177, boba.imageView.frame.origin.y == 765{
                        boba.imageView.removeFromSuperview()
                }
            }
        }
    }
        
        
    func scoreUpdate(){
        let boba = self.bubbleArray
    }
}



//跳ね返しのクラス
class Bubble {
    var imageView: UIImageView
    var vx: CGFloat = CGFloat.random(in: -3...3)
    var vy: CGFloat = CGFloat.random(in: -3...3)
    
    init (imageView: UIImageView) {
        self.imageView = imageView
    }
}







}

