//
//  SuggestedCategoryTableViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/23/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit


class SuggestedCategoryTableViewController: UITableViewController {
    var SuggestedCategoryNames: [String] = ["Everything",
        "Grocery Stores",
        "Restaurants",
        "Gas Stations",
        "Movies",
        "Home Improvement",
        "Department Stores",
        "Ground Transportation",
        "Airlines",
        "Hotels",
        "Amazon.com"
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return SuggestedCategoryNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel?.text = SuggestedCategoryNames[indexPath.row]
        return cell
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GoBackToInsertDiscount")
        {
            var selectedIndex = tableView.indexPathForSelectedRow()?.row
            var CategoryName = SuggestedCategoryNames[selectedIndex!]
            print("SuggestedCategory:")
            print(SuggestedCategoryNames[selectedIndex!])
            print("\n")
            var viewController : InsertDiscountViewController = segue.destinationViewController as! InsertDiscountViewController
            viewController.CategoryName = CategoryName
        }
    }
*/
 /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var discount: CardInfo = CardInfo()
        //cardInfo.Name = SuggestedCardNames[indexPath.row]
        self.navigationController?.popViewControllerAnimated(true)
    }
*/

}
