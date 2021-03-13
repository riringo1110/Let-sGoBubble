//
//  SleepingViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class SleepingViewController: UIViewController {
    
    var currentTime = CurrentTime()
    var alarm = Alarm()
    
    var selectedTime: String!
    
    let saveData: UserDefaults = UserDefaults.standard
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var selectedTimeLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        selectedTime = saveData.object(forKey: "SelectedTime") as? String
        selectedTimeLabel.text = "YOUR ALARM \(String(selectedTime))"
        }
       
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

