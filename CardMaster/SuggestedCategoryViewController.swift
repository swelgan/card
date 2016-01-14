//
//  SuggestedCategoryViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/23/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit
/*
protocol SuggestedCategoryViewControllerDelegate
{
    func SuggestedCategoryViewControllerResponse(CategoryName: String)
}
*/
class SuggestedCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var isQuery : Bool = false
    
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
   // var delegate:InsertDiscountViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        return SuggestedCategoryNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel?.text = SuggestedCategoryNames[indexPath.row]
        return cell
    }
    
/*    func backViewController() -> UIViewController {
        let numberOfViewControllers = self.navigationController!.viewControllers.count;
        if(numberOfViewControllers < 2) {
            return nil
        } else {
            return self.navigationController!.viewControllers[numberOfViewControllers - 2]
        }
    } */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let numberOfViewControllers = self.navigationController!.viewControllers.count
        if (isQuery) {
            let previousController = self.navigationController!.viewControllers[numberOfViewControllers - 2] as! QueryDiscountViewController
            previousController.CategoryLabel.text = SuggestedCategoryNames[indexPath.row]
        } else {
            let previousController = self.navigationController!.viewControllers[numberOfViewControllers - 2] as! InsertDiscountViewController
            previousController.CategoryLabel.text = SuggestedCategoryNames[indexPath.row]
        }
//        self.delegate?.suggestedCategoryViewControllerResponse(SuggestedCategoryNames[indexPath.row])
        self.navigationController?.popViewControllerAnimated(true)
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
