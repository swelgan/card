//
//  SuggestedCardsTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/20/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class SuggestedCardsTableViewController: UITableViewController {

    var SuggestedCardNames: [String] = ["American Express",
                                        "Bank of America",
                                        "Chase",
                                        "Citibank",
                                        "Discover Card",
                                        "Barclaycard",
                                        "Best Buy Credit Card",
                                        "Capital One Credit Card",
                                        "GE Capital",
                                        "Kohls Charge Card",
                                        "PNC Bank",
                                        "Target Card",
                                        "US Bank",
                                        "Wells Fargo Bank"
                                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return SuggestedCardNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SuggestedCardCell = tableView.dequeueReusableCellWithIdentifier("SuggestedCardCell") as! SuggestedCardCell
        cell.NameLabel.text = SuggestedCardNames[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cardInfo: CardInfo = CardInfo()
        cardInfo.Name = SuggestedCardNames[indexPath.row]
        let isInserted = ModelManager.getInstance().addCardData(cardInfo)
        print(cardInfo.Name, terminator: "");
        if isInserted {
            Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
