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
    @IBOutlet weak var label1: UILabel!
    
    // サンプルデータ
    var sampleData:  Array<Float> = [10000, 12345, 20000, 13000, 9000]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return CGFloat(sampleData[index])
    }
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> NSInteger {
        return 5
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
