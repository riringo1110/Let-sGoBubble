//
//  SetViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class SetViewController: UIViewController {
    
    let alarm = Alarm()
    var setTime: String!
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
    
//    @IBAction func timePicker(_ sender: UIDatePicker) {
//        let format = DateFormatter ()
//        format.dateFormat = "HH:mm"
//        setTime = format.string (from: sender.date)
//        saveData.set(setTime, forKey: "SetTime")
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            if segue.identifier == "toSleepingView" {
//                let next = segue.destination as! SleepingViewController
//                next.selectedTime = self.setTime
//            }
//    }
    
    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
        //AlarmにあるselectedWakeUpTimeに入力した日付を代入
        alarm.selectedWakeUpTime = sleepTimePicker.date
        saveData.set(alarm.selectedWakeUpTime, forKey: "SelectedTime") 
        
        
        alarm.runTimer()
        
        let alert = UIAlertController(
            title: "GOOD NIGHT",
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
