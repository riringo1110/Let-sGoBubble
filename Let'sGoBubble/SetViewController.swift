//
//  SetViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class SetViewController: UIViewController {
    
    let alarm = Alarm()
    
    @IBOutlet var sleepTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIDatePickerを.timeモードにする
        sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
        //現在の時間をDatePickerに表示
        sleepTimePicker.setDate(Date(), animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //AlarmでsleepTimerがnilじゃない場合
        if alarm.sleepTimer != nil{
            //再生されているタイマーを止める
            alarm.stopTimer()
        }
    }
    
    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
        //AlarmにあるselectedWakeUpTimeに入力した日付を代入
        alarm.selectedWakeUpTime = sleepTimePicker.date
       
        alarm.runTimer()
        
        performSegue(withIdentifier: "toSleepingView", sender: nil)
    }
}
