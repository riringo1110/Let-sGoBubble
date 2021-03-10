//
//  CurrentTime.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/03/07.
//

import UIKit

class CurrentTime {

    var timer: Timer?
        var currentTime: String?
        var df = DateFormatter()
        weak var delegate: SleepingViewController?

        init() {
            if timer == nil{
                //タイマーをセット、一秒ごとにupdateCurrentTimeを呼ぶ
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
            }
        }

        @objc private func updateCurrentTime(){
            //フォーマットの指定
            df.dateFormat = "HH:mm"
            //timezoneの設定
            df.timeZone = TimeZone.current
            //timeZoneの文字列化
            let timezoneDate = df.string(from: Date())
            currentTime = timezoneDate
            delegate?.updateTime(currentTime!)
        }

   
}
