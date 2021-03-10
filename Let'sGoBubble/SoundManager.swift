//
//  SoundManager.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/03.
//

import UIKit
import AVFoundation

class SoundManager: UIViewController {

    static let shared = SoundManager()
    
    var bgmAudioPlayer: AVAudioPlayer?
    var seAudioPlayer: AVAudioPlayer?
    
    // サウンドエフェクト
    func playSE(fileName: String) {
        
        // サウンドの初期化
        guard let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3") else {
            
            assert(false, "ファイル名が間違っているので、読み込めません")
            return
        }
        let fileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            
            seAudioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            seAudioPlayer?.prepareToPlay()
            seAudioPlayer?.play()
        } catch let error {
            
            assert(false, "サウンドの設定中にエラーが発生しました (\(error.localizedDescription))")
        }
    }
    
    func playBGM(fileName: String) {
        
        // サウンドの初期化
        guard let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3") else {
            
            assert(false, "ファイル名が間違っているので、読み込めません")
            return
        }
        let fileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            
            bgmAudioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            bgmAudioPlayer?.numberOfLoops = -1
            bgmAudioPlayer?.prepareToPlay()
            bgmAudioPlayer?.play()
        } catch let error {
            
            assert(false, "サウンドの設定中にエラーが発生しました (\(error.localizedDescription))")
        }
    }
    
    func stopBGM() {
        
        // BGMが流れたままなら止められるように
        bgmAudioPlayer?.stop()
    }
}
