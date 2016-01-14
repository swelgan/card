//
//  InsertCardViewController.swift
//  CardMaster
//
//  Created by Jue Wang on 9/19/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit


class InsertCardViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    var isEdit : Bool = false
    var cardData : CardInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isEdit)
        {
            txtName.text = cardData.Name;
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIButton Action methods
    
    @IBAction func btnBackClicked(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnSaveClicked(sender: AnyObject)
    {
        if(txtName.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter card name.", delegate: nil)
        } else {
            if(isEdit)
            {
                let cardInfo: CardInfo = CardInfo()
                cardInfo.RollNo = cardData.RollNo
                cardInfo.Name = txtName.text!
                let isUpdated = ModelManager.getInstance().updateCardData(cardInfo)
                if isUpdated {
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
            }
            else
            {
                let cardInfo: CardInfo = CardInfo()
                cardInfo.Name = txtName.text!
                let isInserted = ModelManager.getInstance().addCardData(cardInfo)
                print(cardInfo.Name, terminator: "");
                if isInserted {
                    Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func btnDeleteClicked(sender: AnyObject) {
   //     let btnDelete : UIButton = sender as! UIButton
      //  var selectedIndex : Int = btnDelete.tag
        let cardInfo: CardInfo = CardInfo()
        cardInfo.RollNo = cardData.RollNo
        cardInfo.Name = txtName.text!
//        var cardInfo: CardInfo = marrCardData.objectAtIndex(selectedIndex) as! CardInfo
        let isDeleted = ModelManager.getInstance().deleteCardData(cardInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
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
