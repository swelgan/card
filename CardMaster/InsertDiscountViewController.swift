//
//  InsertDiscountViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/20/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

class InsertDiscountViewController: UIViewController {

    @IBOutlet weak var CategoryLabel: UITextField!
    @IBOutlet weak var StoreNameLabel: UITextField!
    @IBOutlet weak var DiscountLabel: UITextField!
    @IBOutlet weak var OffAmountLabel: UITextField!
    @IBOutlet weak var TotalAmountLabel: UITextField!
    @IBOutlet weak var StartDateLabel: UITextField!
    @IBOutlet weak var ExpireDateLabel: UITextField!
    
    var thisCardId : String = ""
    var thisCardName : String = ""
    var isStartData : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.blackColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: "tappedToolBarBtn:")
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed:")
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Select a date"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        StartDateLabel.inputAccessoryView = toolBar
        ExpireDateLabel.inputAccessoryView = toolBar
    }


    func donePressed(sender: UIBarButtonItem) {
        
        if (isStartData) {
            StartDateLabel.resignFirstResponder()
        } else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            let startDate = dateFormatter.dateFromString(StartDateLabel.text!)
            let expireDate = dateFormatter.dateFromString(ExpireDateLabel.text!)
            print(expireDate)
            let dateComparisionResult = NSCalendar.currentCalendar().compareDate(startDate!, toDate: expireDate!,
                toUnitGranularity: .Hour)
//            var dateComparisionResult:NSComparisonResult = NSCalender.startDate.compare(expireDate)
            let TodayComparisionResult = NSCalendar.currentCalendar().compareDate(NSDate(), toDate: expireDate!,
                toUnitGranularity: .Hour)
            
            if (dateComparisionResult == NSComparisonResult.OrderedDescending)
            {
                Util.invokeAlertMethod("", strBody: "The expire date must be larger than start date.", delegate: nil)
            } else if (TodayComparisionResult == NSComparisonResult.OrderedDescending)
            {
                Util.invokeAlertMethod("", strBody: "The expire date should be larger than today's date", delegate: nil)
            } else {
                ExpireDateLabel.resignFirstResponder()
            }
        }
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        if (isStartData) {
            StartDateLabel.text = dateformatter.stringFromDate(NSDate())
            StartDateLabel.resignFirstResponder()
        } else {
            ExpireDateLabel.text = dateformatter.stringFromDate(NSDate())
            ExpireDateLabel.resignFirstResponder()

        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/*    func suggestedCategoryViewControllerResponse(Category: String) {
        self.CategoryLabel.text = Category
    }
  
  */
    //MARK: UIButton Action methods
    
    @IBAction func StartDateEdit(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        isStartData = true
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    @IBAction func EndDateEdit(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        isStartData = false
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("EndDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        StartDateLabel.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func EndDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        ExpireDateLabel.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    @IBAction func btnBackClicked(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnSaveClicked(sender: AnyObject)
    {
        if(CategoryLabel.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter category name.", delegate: nil)
        } else if (DiscountLabel.text == "" && (OffAmountLabel.text == "" || TotalAmountLabel.text == ""))
        {
            Util.invokeAlertMethod("", strBody: "Please enter discount.", delegate: nil)
        } else if (DiscountLabel.text != "" && (OffAmountLabel.text != "" || TotalAmountLabel.text != "")){
            Util.invokeAlertMethod("", strBody: "Please enter only one type of discount.", delegate: nil)
        }
        else {
    /*        if(isEdit)
            {
                var cardInfo: CardInfo = CardInfo()
                cardInfo.RollNo = cardData.RollNo
                cardInfo.Name = txtName.text
                var isUpdated = ModelManager.getInstance().updateCardData(cardInfo)
                if isUpdated {
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
            }
            else
            {*/
            if (DiscountLabel.text != "") {
                let discountInfo: DiscountInfo = DiscountInfo()
                discountInfo.CardId = thisCardId
                discountInfo.CardName = thisCardName
                discountInfo.Category = CategoryLabel.text!
                discountInfo.Discount = DiscountLabel.text!
                discountInfo.StartDate = StartDateLabel.text!
                discountInfo.ExpireDate = ExpireDateLabel.text!
                let isInserted = ModelManager.getInstance().addDiscountData(discountInfo)
                let categoryInfo : CategoryInfo = CategoryInfo()
                categoryInfo.CateogryName = CategoryLabel.text!
                var isCategoryInserted = true
                if (!ModelManager.getInstance().findCategoryData(categoryInfo))
                {
                    print("add category data!")
                    isCategoryInserted = ModelManager.getInstance().addCategoryData(categoryInfo)
                }
                if (isInserted && isCategoryInserted) {
                    Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            } else {
                if (Double(OffAmountLabel.text!) > Double(TotalAmountLabel.text!)) {
                    //print("here!!\n", terminator: "")
                    Util.invokeAlertMethod("", strBody: "Off amount should not be larger than total amount.", delegate: nil)
                } else {
                    let offerInfo: OfferInfo = OfferInfo()
                    offerInfo.CardId = thisCardId
                    offerInfo.CardName = thisCardName
                    offerInfo.Category = CategoryLabel.text!
                    offerInfo.StoreName = StoreNameLabel.text!
                    offerInfo.OffAmount = OffAmountLabel.text!
                    offerInfo.TotalAmount = TotalAmountLabel.text!
                    let isInserted = ModelManager.getInstance().addOfferData(offerInfo)
                    if isInserted {
                        Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                    } else {
                        Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                    }
                }
            }
            //}
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
/*
    @IBAction func btnDeleteClicked(sender: AnyObject) {
        var btnDelete : UIButton = sender as! UIButton
        var selectedIndex : Int = btnDelete.tag
        var discountInfo: DiscountInfo = DiscountInfo()
        discountInfo.RollNo = cardData.RollNo
        cardInfo.Name = txtName.text
        //        var cardInfo: CardInfo = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
        var isDeleted = ModelManager.getInstance().deleteCardData(cardInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
 */   
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "GoToSuggestedCategory") {
            let goNext = segue.destinationViewController as! SuggestedCategoryViewController
            goNext.delegate = self
        }
    }
  */

}
