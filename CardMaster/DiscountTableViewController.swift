//
//  DiscountTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/20/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class DiscountTableViewController: UITableViewController {

    var marrDiscountData : NSMutableArray!
    var marrOfferData : NSMutableArray!
    var thisCardId : String = ""
    var thisCardName : String = ""
   
    @IBOutlet weak var tbDiscountData: UITableView!
    
    @IBAction func Done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getDiscountData()
    }

    // MARK: Other methods
    
    func getDiscountData() {
        marrDiscountData = NSMutableArray()
        marrDiscountData = ModelManager.getInstance().getAllDiscountData(thisCardId)
        marrOfferData = NSMutableArray()
        marrOfferData = ModelManager.getInstance().getAllOfferData(thisCardId)
        tbDiscountData.reloadData()
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
        return marrDiscountData.count + marrOfferData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DiscountCell = tableView.dequeueReusableCellWithIdentifier("DiscountCell") as! DiscountCell
        if (indexPath.row < marrDiscountData.count) {
            let discount:DiscountInfo = marrDiscountData.objectAtIndex(indexPath.row) as! DiscountInfo
            cell.Category.text = "\(discount.Category)"
            cell.Discount.text = "\(discount.Discount) %"
            cell.StartDate.text = "Start:\(discount.StartDate)"
            cell.ExpireDate.text = "Expire:\(discount.ExpireDate)"
        } else {
            let offer:OfferInfo = marrOfferData.objectAtIndex(indexPath.row - marrDiscountData.count) as! OfferInfo
            cell.Category.text = "\(offer.Category)  \(offer.StoreName)"
            cell.Discount.text = "\(offer.OffAmount) off \(offer.TotalAmount)"
        }
//        cell.btnEdit.tag = indexPath.row
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let selectedIndex = indexPath.row
            if (selectedIndex < marrDiscountData.count) {
                let discountInfo: DiscountInfo = marrDiscountData.objectAtIndex(indexPath.row) as! DiscountInfo
                let isDeleted = ModelManager.getInstance().deleteDiscountData(discountInfo)
                if isDeleted {
                    Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
                    marrDiscountData.removeObjectAtIndex(indexPath.row)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                }
            } else {
                let offerInfo: OfferInfo = marrOfferData.objectAtIndex(indexPath.row - marrDiscountData.count) as! OfferInfo
                let isDeleted = ModelManager.getInstance().deleteOfferData(offerInfo)
                if isDeleted {
                    print("removeIndex:", terminator: "")
                    print(indexPath.row - marrDiscountData.count, terminator: "")
                    print("\n", terminator: "")
                    marrOfferData.removeObjectAtIndex(indexPath.row - marrDiscountData.count)
                    Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                }
            }
           // self.getDiscountData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        } //else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}
    }
    

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
    
    //MARK: Navigation methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addDiscountSegue")
        {
            let viewController : InsertDiscountViewController = segue.destinationViewController as! InsertDiscountViewController
            viewController.thisCardId = thisCardId
            viewController.thisCardName = thisCardName
        }
/*        if(segue.identifier == "editSegue")
        {
            var btnEdit : UIButton = sender as! UIButton
            var selectedIndex : Int = btnEdit.tag
            var viewController : InsertCardViewController = segue.destinationViewController as! InsertCardViewController
            viewController.isEdit = true
            viewController.cardData = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
        } else if (segue.identifier == "GoToDiscounts")
        {
            var selectedIndex = tableView.indexPathForSelectedRow()?.row
            var viewController : DiscountTableViewController = segue.destinationViewController as! DiscountTableViewController
            var cardInfo = marrCardData.objectAtIndex(selectedIndex!) as! CardInfo
            viewController.thisCardId = cardInfo.RollNo
        }*/
    }


}
