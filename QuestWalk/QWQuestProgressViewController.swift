//
//  QWQuestProgressViewController.swift
//  QuestWalk
//
//  Created by Tsukasa Arima on 10/22/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit

class QWQuestProgressViewController: UIViewController {

    
    @IBOutlet weak var QuestStart: UIButton!
    // クエストの実行時間を変数として保存
    var questStartTime:NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchQuestStart(sender: AnyObject) {
        questStartTime = NSDate()
        // 開始時刻の表示
        print("starttime" + String(questStartTime))
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
