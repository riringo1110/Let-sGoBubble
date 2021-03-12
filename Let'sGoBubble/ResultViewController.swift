//
//  ResultViewController.swift
//  Let'sGoBubble
//
//  Created by Ririko on 2021/02/27.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var latestLabel: UILabel!
    
    let saveData: UserDefaults = UserDefaults.standard
    
    var score: Int = 0
    var scoreArray = [Int]()
    var latestScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if saveData.object(forKey: "scoreArray") != nil {
            scoreArray = saveData.array(forKey: "scoreArray") as! [Int]
            resultLabel.text = String("\(scoreArray.last!)secs")
        }
        
        if let penultimate = scoreArray.penultimate(){
            latestLabel.text = String("YOUR LATEST TIME: \(penultimate)secs")
            print(penultimate)
            print(scoreArray)
        }
    }
}

extension Array {
    func penultimate() -> Element? {
        if self.count < 2 {
            return nil
        }
        let index = self.count - 2
        return self[index]
    }
}
