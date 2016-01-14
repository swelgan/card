//
//  CategoryTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 11/22/15.
//  Copyright © 2015 Jue Wang. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var marrCategoryData : NSMutableArray!
    
    @IBOutlet weak var tbCategoryView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getCategoryData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marrCategoryData.count
    }
    
    func getCategoryData() {
        marrCategoryData = NSMutableArray()
        marrCategoryData = ModelManager.getInstance().getAllCategoryData()
        tbCategoryView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
//        let cell:UITableViewCell = self.tbCategoryView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        let categoryInfo:CategoryInfo = marrCategoryData.objectAtIndex(indexPath.row) as! CategoryInfo
        cell.textLabel?.text = "\(categoryInfo.CateogryName)"
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GoToDiscounts")
        {
            let selectedIndex = tableView.indexPathForSelectedRow?.row
            let  viewController : CategoryDiscountTableViewController = segue.destinationViewController as! CategoryDiscountTableViewController
//            let viewController = nav.topViewController as! DiscountTableViewController
            //            var viewController : DiscountTableViewController = segue.destinationViewController as! DiscountTableViewController
            let categoryInfo = marrCategoryData.objectAtIndex(selectedIndex!) as! CategoryInfo
            viewController.thisCategoryName = categoryInfo.CateogryName
        }
    }
}
