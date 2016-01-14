//
//  CategoryDiscountTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 12/10/15.
//  Copyright © 2015 Jue Wang. All rights reserved.
//

import UIKit

class CategoryDiscountTableViewController: UITableViewController {

    var marrDiscountData : NSMutableArray!
    var marrOfferData : NSMutableArray!
    var thisCategoryName : String = ""
    
    @IBOutlet weak var tbView: UITableView!
    
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

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marrDiscountData.count + marrOfferData.count
    }

    // Other methods
    
    func getDiscountData() {
        marrDiscountData = NSMutableArray()
        marrDiscountData = ModelManager.getInstance().getCategoryDiscountData(thisCategoryName)
        marrOfferData = NSMutableArray()
        marrOfferData = ModelManager.getInstance().getCategoryOfferData(thisCategoryName)
        tbView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if (indexPath.row < marrDiscountData.count) {
            let discount:DiscountInfo = marrDiscountData.objectAtIndex(indexPath.row) as! DiscountInfo
            cell.textLabel?.text = "\(discount.CardName): \(discount.Discount) % off"
        } else {
            let offer:OfferInfo = marrOfferData.objectAtIndex(indexPath.row - marrDiscountData.count) as! OfferInfo
            cell.textLabel?.text = "\(offer.CardName): \(offer.OffAmount) off \(offer.TotalAmount)"
        }
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

}
