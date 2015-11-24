//
//  QWMeasurementViewController.swift
//  QuestWalk
//
//  Created by Tsukasa Arima on 11/11/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit

class QWMeasurementViewController: UIViewController {

    @IBOutlet weak var MeasureStartButton: UIButton!
    
    @IBOutlet weak var MeasureResetButton: UIButton!

    @IBOutlet weak var TimeLabel: UILabel!
    var timer: NSTimer!
    var startTime: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        MeasureResetButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func MeasureStartButtonAction(sender: AnyObject) {
        // timerの開始
//        MeasureResetButton.hidden = true
        if MeasureStartButton.currentTitle == "Start" {
            if startTime == 0.0 {
                startTime = NSDate.timeIntervalSinceReferenceDate()

            }
            MeasureStartButton.setTitle("Stop", forState: .Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
        }
        // timerの停止
        else {
            MeasureStartButton.setTitle("Start", forState: .Normal)
            timer.invalidate()
        }
    }
    
    @IBAction func MeasureResetButtonAction(sender: AnyObject) {
        startTime = 0.0
        MeasureStartButton.setTitle("Start", forState: .Normal)
        timer.invalidate()
        TimeLabel.text = "00:00:00.00"
    }
    // タイマーの増加とLabelに反映の処理
    func onUpdate(timer: NSTimer){
        let cTime = NSDate.timeIntervalSinceReferenceDate() - startTime
        let hour = integer_t(cTime/(60*60))
        let minute = integer_t(fmod(cTime/60, 60))
        let second = integer_t(fmod(cTime, 60))
        let milisecond = integer_t((cTime - floor(cTime))*100)
        let NowTime = NSString(format: "%02d:%02d:%02d.%02d", hour, minute, second, milisecond)
        self.TimeLabel.text = String(NowTime)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
