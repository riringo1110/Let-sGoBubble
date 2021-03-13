//
//  SetViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class SetViewController: UIViewController {
    
    let alarm = Alarm()
    var setTime: Date!
    var format = DateFormatter()
    let saveData: UserDefaults = UserDefaults.standard
    
    
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
        
        //setした時間をsaveDateに保存
        setTime = sleepTimePicker.date
        format.dateFormat = "HH:mm"
        let selectedTime = format.string(from: setTime)
        saveData.set(selectedTime, forKey: "SelectedTime")
        
        alarm.runTimer()
        
        let alert = UIAlertController(
            title: "KEEP APP OPEN",
            message: "アラームはアプリを閉じると作動しません",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            
            //アラートが消えて0.5秒後に画面遷移
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "toSleepingView", sender: nil)
            }
        }
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
