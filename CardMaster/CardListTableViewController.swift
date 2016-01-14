//
//  CardListTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/19/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class CardListTableViewController: UITableViewController {
    
    var marrCardData : NSMutableArray!
    
    @IBOutlet weak var tbCardData: UITableView!
    
    @IBAction func Done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // @IBOutlet weak var tbCardData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getCardData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Other methods
    
    func getCardData() {
        marrCardData = NSMutableArray()
        marrCardData = ModelManager.getInstance().getAllCardData()
        tbCardData.reloadData()
    }
    
    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
*/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return marrCardData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CardCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CardCell
        let card:CardInfo = marrCardData.objectAtIndex(indexPath.row) as! CardInfo
        cell.CardName.text = "\(card.Name)  \n"
     //   cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
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
           // var btnDelete : UIButton = sender as! UIButton
            var selectedIndex : Int = Int(indexPath.row)
            var cardInfo: CardInfo = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
            var isDeleted = ModelManager.getInstance().deleteCardData(cardInfo)
            if isDeleted {
                Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            } else {
                Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
            self.getCardData()

        }/* else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }  */  
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
    
    //MARK: UIButton Action methods
    /*
    @IBAction func btnDeleteClicked(sender: AnyObject) {
        var btnDelete : UIButton = sender as! UIButton
        var selectedIndex : Int = btnDelete.tag
        var cardInfo: CardInfo = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
        var isDeleted = ModelManager.getInstance().deleteCardData(cardInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
        self.getCardData()
    }
*/
    
    @IBAction func btnEditClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("editSegue", sender: sender)
    }
    
    //MARK: Navigation methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController : InsertCardViewController = segue.destinationViewController as! InsertCardViewController
            viewController.isEdit = true
            viewController.cardData = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
        } else if (segue.identifier == "GoToDiscounts")
        {
            let selectedIndex = tableView.indexPathForSelectedRow?.row
            let nav = segue.destinationViewController as! UINavigationController
            let viewController = nav.topViewController as! DiscountTableViewController
//            var viewController : DiscountTableViewController = segue.destinationViewController as! DiscountTableViewController
            let cardInfo = marrCardData.objectAtIndex(selectedIndex!) as! CardInfo
            viewController.thisCardId = cardInfo.RollNo
            viewController.thisCardName = cardInfo.Name
            print("GoToDiscounts:", terminator: "")
            print(cardInfo.RollNo, terminator: "")
            print("\n", terminator: "")
        }
    }


}
