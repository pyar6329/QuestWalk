//
//  QWMeasurementViewController.swift
//  QuestWalk
//
//  Created by Tsukasa Arima on 11/11/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit

class QWMeasurementViewController: UIViewController {

//    @IBOutlet weak var TimeLabel: UILabel!
//    TimeLabel.text = "hello"
    @IBOutlet weak var MeasureStartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func MeasureStartButtonAction(sender: AnyObject) {
        MeasureStartButton.setTitle("Stop", forState: .Normal)
//        TimeLabel.text = "Hello"

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
