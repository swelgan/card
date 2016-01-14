    //
//  QueryDiscountViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/20/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class QueryDiscountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var CategoryLabel: UITextField!
    @IBOutlet weak var TotalAmountText: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
        
    var marrDiscountData : NSMutableArray!
    var marrOfferData : NSMutableArray!
    var queryResult : NSMutableArray!
    
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
        // Return the number of rows in the section.
        var size : Int = 0
        if (self.marrDiscountData != nil) {
            size = 1//self.marrDiscountData.count
        }
        if (self.marrOfferData != nil) {
            size = size + self.marrOfferData.count
        }
        return size;
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
  //  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
  //      return 1
  //  }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    //    var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("addItem", forIndexPath: indexPath) as UITableViewCell
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        print("count=", queryResult.count)
        if (queryResult.count == 0) {  //find nothing
            cell.textLabel?.text = "Not found!"
        } else {
            //     var cell:QueryDiscountCell = self.tableView.dequeueReusableCellWithIdentifier("QueryDiscountCell") as!
            let result:QueryResult = queryResult.objectAtIndex(indexPath.row) as! QueryResult
            cell.textLabel?.text = "\(result.CardName): \(result.Discount) (Saving:\(result.TotalSaving))"
        }
        
  /*      if (indexPath.row < marrDiscountData.count) {
            let discount:DiscountInfo = marrDiscountData.objectAtIndex(indexPath.row) as! DiscountInfo
            cell.textLabel?.text = "\(discount.CardName):  \(discount.Discount)%"
        } else {
            let offer:OfferInfo = marrOfferData.objectAtIndex(indexPath.row - marrDiscountData.count) as! OfferInfo
            cell.textLabel?.text = "\(offer.CardName):  \(offer.StoreName)  \(offer.OffAmount) off \(offer.TotalAmount)"
        }*/
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnBackClicked(sender: AnyObject)
    {
    
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func btnSearchClicked(serder: AnyObject)
    {
        self.DismissKeyboard()
        if(CategoryLabel.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter category name.", delegate: nil)
        } else if (TotalAmountText.text == "") {
            Util.invokeAlertMethod("", strBody: "Please enter total amount.", delegate: nil)
        } else {
            marrDiscountData = NSMutableArray()
            marrDiscountData = ModelManager.getInstance().queryDiscountDataSort(CategoryLabel.text!)
            marrOfferData = NSMutableArray()
            let offer:OfferInfo = OfferInfo()
            offer.Category = CategoryLabel.text!
            offer.TotalAmount = TotalAmountText.text!
            marrOfferData = ModelManager.getInstance().queryOfferDataSort(offer)
            queryResult = NSMutableArray()
            queryResult = mergeResults(marrDiscountData, marrOfferData: marrOfferData)
            self.tableView.reloadData()
        }
    }
    
    func mergeResults(marrDiscountData: NSMutableArray, marrOfferData: NSMutableArray) -> NSMutableArray {
        var idx0 = 0
        var idx1 = 0
        let tmpResult : NSMutableArray = NSMutableArray()
        while(idx0 < marrDiscountData.count || idx1 < marrOfferData.count) {
            var save0 = 0.0
            var save1 = 0.0
            var discount:DiscountInfo = DiscountInfo()
            var offer:OfferInfo = OfferInfo()
            if (idx0 < marrDiscountData.count) {
                discount = marrDiscountData.objectAtIndex(idx0) as! DiscountInfo
                save0 = Double(discount.Discount)! * Double(TotalAmountText.text!)! / 100.0
                print("save0=", save0)
            }
            if (idx1 < marrOfferData.count) {
                offer = marrOfferData.objectAtIndex(idx1) as! OfferInfo
                save1 = Double(offer.OffAmount)!
                print("save1=", save1)
            }
            if (save0 > save1) {
                let result:QueryResult = QueryResult()
                result.CardName = discount.CardName
                result.Discount = "\(discount.Discount)%"
                result.TotalSaving = String(save0)
                tmpResult.addObject(result)
                idx0++
            } else {
                let result:QueryResult = QueryResult()
                result.CardName = offer.CardName
                result.Discount = "\(offer.OffAmount) off \(offer.TotalAmount)"
                result.TotalSaving = String(save1)
                tmpResult.addObject(result)
                idx1++
            }
        }
        return tmpResult
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GoToSuggestedCategory") {
            let viewController : SuggestedCategoryViewController = segue.destinationViewController as! SuggestedCategoryViewController
            viewController.isQuery = true
        }
    }
    

}
