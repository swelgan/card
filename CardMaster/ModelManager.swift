//
//  ModelManager.swift
//  CardMaster
//
//  Created by Jue Wang on 9/19/15.
//  Copyright (c) 2015 Jue Wang. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            print("here!!\n", terminator: "")
            sharedInstance.database = FMDatabase(path: Util.getPath("test.sqlite"))
          }
        return sharedInstance
    }
    
    // Card Info
    func addCardData(cardInfo: CardInfo) -> Bool {
        sharedInstance.database!.open()
        print(sharedInstance.database, terminator: "")
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO card_info (Name) VALUES (?)", withArgumentsInArray: [cardInfo.Name])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateCardData(cardInfo: CardInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE card_info SET Name=? WHERE RollNo=?", withArgumentsInArray: [cardInfo.Name, cardInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteCardData(cardInfo: CardInfo) -> Bool {
        sharedInstance.database!.open()
        var isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM discount_info WHERE CardId=?", withArgumentsInArray: [cardInfo.RollNo])
        if (isDeleted) {
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM card_info WHERE RollNo=?", withArgumentsInArray: [cardInfo.RollNo])
        }
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllCardData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM card_info", withArgumentsInArray: nil)
        let marrCardInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let cardInfo : CardInfo = CardInfo()
                cardInfo.RollNo = resultSet.stringForColumn("RollNo")
                cardInfo.Name = resultSet.stringForColumn("Name")
                marrCardInfo.addObject(cardInfo)
            }
        }
        sharedInstance.database!.close()
        return marrCardInfo
    }
    
    // Category Info
    
    func addCategoryData(categoryInfo: CategoryInfo) -> Bool {
        sharedInstance.database!.open()
        print(sharedInstance.database, terminator: "")
        print("addCategory:", categoryInfo.CateogryName)
       // let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT EXISTS(SELECT 1 FROM category_info WHERE CategoryName=? LIMIT 1)", withArgumentsInArray: [categoryInfo.CateogryName])
        //print("existed?", isExisted)
    /*
       let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM category_info WHERE CategoryName=?", withArgumentsInArray: [categoryInfo.CateogryName])
        print("existed?", resultSet)
         if (resultSet != nil) {
            sharedInstance.database!.close()
            return true
        }*/
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO category_info (CategoryName) VALUES (?)", withArgumentsInArray: [categoryInfo.CateogryName])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateCategoryData(categoryInfo: CategoryInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE category_info SET CateogryName=? WHERE CategoryId=?", withArgumentsInArray: [categoryInfo.CateogryName, categoryInfo.CategoryId])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    /*
    func deleteCategoryData(categoryInfo: CategoryInfo) -> Bool {
        sharedInstance.database!.open()
        var isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM discount_info WHERE CardId=?", withArgumentsInArray: [cardInfo.RollNo])
        if (isDeleted) {
            isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM card_info WHERE RollNo=?", withArgumentsInArray: [cardInfo.RollNo])
        }
        sharedInstance.database!.close()
        return isDeleted
    }*/
    
    func getAllCategoryData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM category_info", withArgumentsInArray: nil)
        let marrCategoryInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let categoryInfo : CategoryInfo = CategoryInfo()
                categoryInfo.CategoryId = resultSet.stringForColumn("CategoryId")
                categoryInfo.CateogryName = resultSet.stringForColumn("CategoryName")
                marrCategoryInfo.addObject(categoryInfo)
                print("getAll:", categoryInfo.CateogryName)
            }
        }
        sharedInstance.database!.close()
        return marrCategoryInfo
    }

    func findCategoryData(categoryInfo: CategoryInfo) -> Bool {
        sharedInstance.database!.open()
       // let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO category_info (CategoryName) VALUES (?)", withArgumentsInArray: [categoryInfo.CateogryName])
        
      //  let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM category_info", withArgumentsInArray: nil)
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM category_info WHERE CategoryName=?", withArgumentsInArray: [categoryInfo.CateogryName])
        var count = 0
        if (resultSet != nil) {
            while resultSet.next() {
                count++
            }
        }
        print("count", count)
        //  print("find?", resultSet)
        sharedInstance.database!.close()
        //print("find2?", resultSet)
        if (count > 0) {
            return true
        } else {
            return false
        }
    }

    // Discount Info
    func addDiscountData(discountInfo: DiscountInfo) -> Bool {
        sharedInstance.database!.open()
        print(sharedInstance.database, terminator: "")
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO discount_info (CardId, CardName, Category, Discount, StartDate, ExpireDate) VALUES (?, ?, ?, ?, ?, ?)", withArgumentsInArray: [discountInfo.CardId, discountInfo.CardName, discountInfo.Category, discountInfo.Discount, discountInfo.StartDate, discountInfo.ExpireDate])
        // add category info
       // let isCategoryExist = sharedInstance.database!.executeUpdate("SELECT EXISTS(SELECT 1 FROM category_info WHERE CategoryName = ?)", withArgumentsInArray: [discountInfo.Category])
        //if (!isCategoryExist) {
    /*        let categoryInfo : CategoryInfo = CategoryInfo()
            categoryInfo.CateogryName = discountInfo.Category
            let isCategoryInserted = addCategoryData(categoryInfo)
        if(isCategoryInserted == false){ print("not ok")}
        //}*/
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateDiscountData(discountInfo: DiscountInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE discount_info SET CardId=?, CardName=?, Category=?, Discount=?, StartDate=?, ExpireDate=? WHERE DiscountId=?", withArgumentsInArray: [discountInfo.CardId, discountInfo.CardName, discountInfo.Category, discountInfo.Discount, discountInfo.StartDate, discountInfo.ExpireDate, discountInfo.DiscountId])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteDiscountData(discountInfo: DiscountInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM discount_info WHERE DiscountId=?", withArgumentsInArray: [discountInfo.DiscountId])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllDiscountData(CardId: String) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM discount_info WHERE CardId = ?", withArgumentsInArray: [CardId])
        let marrDiscountInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let discountInfo : DiscountInfo = DiscountInfo()
                discountInfo.DiscountId = resultSet.stringForColumn("DiscountId")
                discountInfo.CardId = resultSet.stringForColumn("CardId")
                discountInfo.CardName = resultSet.stringForColumn("CardName")
                discountInfo.Category = resultSet.stringForColumn("Category")
                discountInfo.Discount = resultSet.stringForColumn("Discount")
                discountInfo.StartDate = resultSet.stringForColumn("StartDate")
                discountInfo.ExpireDate = resultSet.stringForColumn("ExpireDate")
                marrDiscountInfo.addObject(discountInfo)
            }
        }
        sharedInstance.database!.close()
        return marrDiscountInfo
    }
    
    func getCategoryDiscountData(CategoryName: String) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM discount_info WHERE Category = ?", withArgumentsInArray: [CategoryName])
        let marrDiscountInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let discountInfo : DiscountInfo = DiscountInfo()
                discountInfo.DiscountId = resultSet.stringForColumn("DiscountId")
                discountInfo.CardId = resultSet.stringForColumn("CardId")
                discountInfo.CardName = resultSet.stringForColumn("CardName")
                discountInfo.Category = resultSet.stringForColumn("Category")
                discountInfo.Discount = resultSet.stringForColumn("Discount")
                discountInfo.StartDate = resultSet.stringForColumn("StartDate")
                discountInfo.ExpireDate = resultSet.stringForColumn("ExpireDate")
                marrDiscountInfo.addObject(discountInfo)
            }
        }
        sharedInstance.database!.close()
        return marrDiscountInfo
    }

    
    func queryDiscountDataSort(CategoryName: String) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM discount_info WHERE Category = ? ORDER BY Discount DESC", withArgumentsInArray: [CategoryName])
        let marrDiscountInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let discountInfo : DiscountInfo = DiscountInfo()
                discountInfo.DiscountId = resultSet.stringForColumn("DiscountId")
                discountInfo.CardId = resultSet.stringForColumn("CardId")
                discountInfo.CardName = resultSet.stringForColumn("CardName")
                discountInfo.Category = resultSet.stringForColumn("Category")
                discountInfo.Discount = resultSet.stringForColumn("Discount")
                discountInfo.StartDate = resultSet.stringForColumn("StartDate")
                discountInfo.ExpireDate = resultSet.stringForColumn("ExpireDate")
                print(discountInfo.Discount, terminator: "")
                print("\n", terminator: "")
                marrDiscountInfo.addObject(discountInfo)
            }
        }
        sharedInstance.database!.close()
        return marrDiscountInfo
    }
    
    func addOfferData(offerInfo: OfferInfo) -> Bool {
        sharedInstance.database!.open()
        print(sharedInstance.database, terminator: "")
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO offer_info (CardId, CardName, StoreName, Category, TotalAmount, OffAmount) VALUES (?, ?, ?, ?, ?, ?)", withArgumentsInArray: [offerInfo.CardId, offerInfo.CardName, offerInfo.StoreName, offerInfo.Category, offerInfo.TotalAmount, offerInfo.OffAmount])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateOfferData(offerInfo: OfferInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE offer_info SET CardId=?, CardName=?, StoreName=?, Category=?, TotalAmount=?, OffAmount=? WHERE OfferId=?", withArgumentsInArray: [offerInfo.CardId, offerInfo.CardName, offerInfo.StoreName, offerInfo.Category, offerInfo.TotalAmount, offerInfo.OffAmount, offerInfo.OfferId])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteOfferData(offerInfo: OfferInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM offer_info WHERE OfferId=?", withArgumentsInArray: [offerInfo.OfferId])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllOfferData(CardId: String) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM offer_info WHERE CardId = ?", withArgumentsInArray: [CardId])
        let marrOfferInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let offerInfo : OfferInfo = OfferInfo()
                offerInfo.OfferId = resultSet.stringForColumn("OfferId")
                offerInfo.CardId = resultSet.stringForColumn("CardId")
                offerInfo.CardName = resultSet.stringForColumn("CardName")
                offerInfo.StoreName = resultSet.stringForColumn("StoreName")
                offerInfo.Category = resultSet.stringForColumn("Category")
                offerInfo.TotalAmount = resultSet.stringForColumn("TotalAmount")
                offerInfo.OffAmount = resultSet.stringForColumn("OffAmount")
                marrOfferInfo.addObject(offerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrOfferInfo
    }
    
    func getCategoryOfferData(CategoryName: String) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM offer_info WHERE Category = ?", withArgumentsInArray: [CategoryName])
        let marrOfferInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let offerInfo : OfferInfo = OfferInfo()
                offerInfo.OfferId = resultSet.stringForColumn("OfferId")
                offerInfo.CardId = resultSet.stringForColumn("CardId")
                offerInfo.CardName = resultSet.stringForColumn("CardName")
                offerInfo.StoreName = resultSet.stringForColumn("StoreName")
                offerInfo.Category = resultSet.stringForColumn("Category")
                offerInfo.TotalAmount = resultSet.stringForColumn("TotalAmount")
                offerInfo.OffAmount = resultSet.stringForColumn("OffAmount")
                marrOfferInfo.addObject(offerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrOfferInfo
    }

    
    func queryOfferDataSort(offerInfo: OfferInfo) -> NSMutableArray {
        print("inquery\n", terminator: "")
        print(offerInfo.TotalAmount, terminator: "")
        print("\n", terminator: "")
        sharedInstance.database!.open()
        //var resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM offer_info WHERE Category = ? ORDER BY OffAmount DESC", withArgumentsInArray: [offerInfo.Category])
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM offer_info WHERE Category = ? AND TotalAmount <= ? ORDER BY OffAmount DESC", withArgumentsInArray: [offerInfo.Category, offerInfo.TotalAmount])
        
        let marrOfferInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let offerInfo : OfferInfo = OfferInfo()
                offerInfo.OfferId = resultSet.stringForColumn("OfferId")
                offerInfo.CardId = resultSet.stringForColumn("CardId")
                offerInfo.CardName = resultSet.stringForColumn("CardName")
                offerInfo.StoreName = resultSet.stringForColumn("StoreName")
                offerInfo.Category = resultSet.stringForColumn("Category")
                offerInfo.TotalAmount = resultSet.stringForColumn("TotalAmount")
                offerInfo.OffAmount = resultSet.stringForColumn("OffAmount")
                //print(discountInfo.Discount)
                //print("\n")
                marrOfferInfo.addObject(offerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrOfferInfo
    }

}
