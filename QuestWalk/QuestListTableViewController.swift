//
//  QuestListTableViewController.swift
//  QuestWalk
//
//  Created by Ohashi Yusuke on 10/17/15.
//  Copyright © 2015 SBR2015. All rights reserved.
//

import UIKit

class QuestListTableViewController: UITableViewController {
    var questList:Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = NSLocalizedString("Quest", comment: "")
        questList = Array<String>()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://infinite-shelf-2944.herokuapp.com/quest/list")!)
        httpGet(request, success: { (dict) -> Void in
            //  成功した場合の処理を書く
            if let data = dict { // dictが nilかどうかを判定する
                let items:NSArray = data.objectForKey("items") as! NSArray
                items.enumerateObjectsUsingBlock({ (item, Index, stop) -> Void in
                    self.questList.append((item as! NSDictionary).objectForKey("title") as! String)
                })
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()                    
                })
            }
            }) { (error) -> Void in
                // 失敗した場合の処理を書く
           print(error!.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = questList[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func httpGet(request: NSURLRequest!, success: (NSDictionary?) -> Void, error: (NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, err) -> Void in
            if err != nil {
                error(err)
            } else {
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    // エラーが起こらなければ後続の処理...
                    success(dict)
                } catch  {
                    // エラーが起こったらここに来るのでエラー処理などをする
                }
            }
        }
        task.resume()
    }

}
