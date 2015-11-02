//
//  QWStatusGraphViewController.swift
//  QuestWalk
//
//  Created by Johnny on 11/1/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion

// BEMSimpleLineGraphDelegateとBEMSimpleLineGraphDataSourceの2つのプロトコルを追加
class QWStatusGraphViewController: UIViewController, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource {
    
    // メンバー変数でないと動作しないので注意
    let pedometer = CMPedometer()
    var weekList:Array<Float>!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    func setup() {
        // init の中身
        getWeekData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 描画の方が早いのでタイマーで遅延させる
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onUpdate:", userInfo: nil, repeats: false)
    }
    
    func onUpdate(timer:NSTimer) {
        // グラフのViewを作成（今回はメインビューと同じ大きさのビューを作ります）
        let graphView: BEMSimpleLineGraphView = BEMSimpleLineGraphView(frame: CGRectMake(0, 50, self.view.bounds.width, (self.view.bounds.height - 50)))
        // データソースを設定 (今回はこのクラスの中にメソッドを書くので、selfを設定)
        graphView.dataSource = self
        // delegateを設定 (今回はこのクラスの中にメソッドを書くので、selfを設定)
        graphView.delegate = self
        graphView.enableTouchReport = true
        graphView.enablePopUpReport = true
        graphView.enableYAxisLabel = true
        graphView.enableXAxisLabel = true
        graphView.enableReferenceAxisFrame = true
        graphView.enableReferenceXAxisLines = true
        graphView.enableReferenceYAxisLines = true
        graphView.enableBezierCurve = false
        graphView.widthLine = 2
        graphView.colorLine = UIColor.orangeColor()
        graphView.colorTop = UIColor.whiteColor()
        graphView.colorBottom = UIColor.whiteColor()
        // メインビューにグラフのViewを追加
        self.view.addSubview(graphView)
    }
    
    // Y軸の値を返すメソッドを作成
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: NSInteger) -> CGFloat {
        //何個目のX軸のポイントかはindexで取得できるので、今回はSampleData配列の中にあるindexの要素をそのまま返します
        return CGFloat(self.weekList[index])
    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> NSInteger {
        return self.weekList.count
    }
    
    func getWeekData() {
        weekList = Array<Float>()
        for i in 0...6 {
            // CMPedometerが利用できるか確認
            if CMPedometer.isStepCountingAvailable() {
                // 今日の0時
                let df = NSDateFormatter()
                df.locale = NSLocale(localeIdentifier: "ja_JP")
                df.dateFormat = "yyyy/MM/dd 00:00:00"
                let fromDate = df.dateFromString(df.stringFromDate(NSDate(timeIntervalSinceNow: Double(-24*60*60*(i+1)))))
                print("###from date### " + df.stringFromDate(NSDate(timeIntervalSinceNow: Double(-24*60*60*(i+1)))))
                // 現在時刻
                let toDate = df.dateFromString(df.stringFromDate(NSDate(timeIntervalSinceNow: Double(-24*60*60*i))))
                print("###to date### " + df.stringFromDate(NSDate(timeIntervalSinceNow: Double(-24*60*60*i))))
                
                // 本日の成果
                pedometer.queryPedometerDataFromDate(fromDate!, toDate: toDate!, withHandler: {
                    [unowned self] data, error in
                    dispatch_sync(dispatch_get_main_queue(), {
                        if error != nil {
                            print("エラー : \(error)")
                        } else {
                            //let lengthFormatter = NSLengthFormatter()
                            // 歩数
                            let steps = data!.numberOfSteps
                            // 距離
                            //let distance = data!.distance!.doubleValue
                            print("Steps: \(steps)")
                            //    + "\n\nDistance : \(lengthFormatter.stringFromMeters(distance))"
                            self.weekList.insert(steps.floatValue, atIndex: 0)
                        }
                    })
                })
            } else {
                print("Cannot use CMPedometer")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
