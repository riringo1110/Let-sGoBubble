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
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var straw: UIImageView!
    @IBOutlet var bottomOfStraw: UIView!
    
    let motionManager = CMMotionManager()
    
    var accelerationX: Double = 0.0
    var accelerationY: Double = 0.0
    
    
    var bubbleImageArray = [UIImageView]()
    var bubbleArray = [Bubble]()
    
    let soundManager = SoundManager.shared
    var audioPlayer : AVAudioPlayer! = nil
    
    var timeCount: Int = 0
    var timer: Timer!
    
    var strawMinX: CGFloat = 0.0
    var strawMaxX: CGFloat = 0.0
    var strawMinY: CGFloat = 0.0
    var strawMaxY: CGFloat = 0.0
    
    var score: Int = 0
    var scoreArray = [Int]()
    let saveData: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strawMinX = bottomOfStraw.frame.origin.x
        strawMaxX = strawMinX + bottomOfStraw.frame.size.width
        strawMinY = bottomOfStraw.frame.origin.y - bottomOfStraw.frame.size.height
        strawMaxY = strawMinY + bottomOfStraw.frame.size.height
        
        bubbleImageArray = [bubble1, bubble2, bubble3, bubble4, bubble5, bubble6, bubble7, bubble8, bubble9, bubble10]
        
        //効果音再生準備
        let soundFilePath = Bundle.main.path(forResource: "パパッ", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }
        audioPlayer.prepareToPlay()
        
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
        
        timeCount = timeCount + 1
        timerLabel.text = String(timeCount)
        
    }
    
    //    //画面が見えるようになる時に呼ばれる
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        soundManager.playBGM(fileName: "higedance")
    //    }
    //
    //画面が見えなくなるときに呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        soundManager.stopBGM()
    }
    //
    func bubbleMove(){
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data,error in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                
                //いくつのタピが残っているか記憶するArray
                var memoryArray = [Int]()
                
                
                for i in 0..<self.bubbleArray.count {
                    
                    let boba = self.bubbleArray[i]
                    let ransu = CGFloat.random(in: 1...10)
                    
                    boba.imageView.center.x += CGFloat(self.accelerationX * Double(ransu))
                    boba.imageView.center.y -= CGFloat(self.accelerationY * Double(ransu))
                    
                    //タピの中心がbottomOfStrawの範囲にきたら
                    if (boba.imageView.frame.origin.x + boba.imageView.frame.size.width / 2) >= self.strawMinX && (boba.imageView.frame.origin.x + boba.imageView.frame.size.width / 2) <= self.strawMaxX, (boba.imageView.frame.origin.y + boba.imageView.frame.size.height / 2) >= self.strawMinY && (boba.imageView.frame.origin.y + boba.imageView.frame.size.height / 2) <= self.strawMaxY {
                        
                        memoryArray.append(i)
                    }
                    
                    boba.imageView.center.x += boba.vx
                    boba.imageView.center.y += boba.vy
                    
                    //画面端にいったら跳ね返る
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
                        boba.vy = -boba.vy
                    }
                    
                    if boba.imageView.frame.origin.y > self.view.frame.height - boba.imageView.frame.height {
                        boba.imageView.frame.origin.y = self.view.frame.height - boba.imageView.frame.height
                        boba.vy = -boba.vy
                    }
                }
                
                //タピオカを消す
                for deleteIndex in memoryArray {
                    self.bubbleArray[deleteIndex].imageView.removeFromSuperview()
                    self.bubbleArray.remove(at: deleteIndex)
                    // 効果音再生
                    self.audioPlayer.currentTime = 0
                    self.audioPlayer.play()
                }
                
                if self.bubbleArray.count == 0 {
                    self.performSegue(withIdentifier: "toResult", sender: nil)
                    self.audioPlayer.stop()
               
                }
                
                //寝起きスコア
                self.score = self.timeCount
                self.scoreArray.append(self.score)
                self.saveData.set(self.scoreArray, forKey: "scoreArray")
            }
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


