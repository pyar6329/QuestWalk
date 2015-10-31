//
//  QWStatusViewController.swift
//  QuestWalk
//
//  Created by Johnny on 10/17/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion

class QWStatusViewController: UIViewController {
    // メンバー変数でないと動作しないので注意
    let pedometer = CMPedometer()
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        onUpdate(NSTimer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onUpdate(timer: NSTimer){
        // CMPedometerが利用できるか確認
        if CMPedometer.isStepCountingAvailable() {
            // 現在時刻
            let toDate = NSDate()
            
            // 今日の0時
            let df = NSDateFormatter()
            df.locale = NSLocale(localeIdentifier: "ja_JP")
            df.dateFormat = "yyyy/MM/dd 00:00:00"
            let fromDate = df.dateFromString(df.stringFromDate(NSDate()))
            // 本日の成果
            pedometer.queryPedometerDataFromDate(fromDate!, toDate: toDate, withHandler: {
                [unowned self] data, error in
                dispatch_async(dispatch_get_main_queue(), {
                    print("update")
                    if error != nil {
                        self.label1.text = "エラー : \(error)"
                        print("エラー : \(error)")
                    } else {
                        let lengthFormatter = NSLengthFormatter()
                        // 歩数
                        let steps = data!.numberOfSteps
                        // 距離
                        let distance = data!.distance!.doubleValue
                        // 速さ
                        //let time = data!.endDate.timeIntervalSinceDate(data!.startDate)
                        //let speed = distance / time
                        // 結果をラベルに出力
                        self.label1.text = "Steps: \(steps)"
                            + "\n\nDistance : \(lengthFormatter.stringFromMeters(distance))"
                            //+ "\n\nSpeed : \(lengthFormatter.stringFromMeters(speed)) / s"
                    }
                })
                })
        } else {
            print("Cannot use CMPedometer")
        }
        
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
