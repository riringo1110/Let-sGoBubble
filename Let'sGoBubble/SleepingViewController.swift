//
//  SleepingViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class SleepingViewController: UIViewController {
    
    var currentTime = CurrentTime()
    
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        currentTime.delegate = self
    }
    
    @IBAction func awake(_ sender: UIButton) {
        
        let alert = UIAlertController(
            title: "ARE YOU READY?",
            message: "スマホを水平にしてください",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            
            //アラートが消えて0.5秒後に画面遷移
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "toGame", sender: nil)
            }
        }
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateTime(_ time:String) {
        timeLabel.text = time
    }
    
}

