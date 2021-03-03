//
//  RuleViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/03.
//

import AVFoundation
import UIKit

let soundManager = SoundManager.shared


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
}
    //画面が見えるようになる時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        soundManager.playBGM(fileName: "tekuteku arukou")
    }

    //画面が見えなくなるときに呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        
       
        super.viewWillDisappear(animated)
        soundManager.stopBGM()
        
        
    
    
    }

}
