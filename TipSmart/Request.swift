//
//  Request.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation
import CoreData

class Request: NSManagedObject {

    @NSManaged var amount: NSNumber
    @NSManaged var category: String
    @NSManaged var percentage: NSNumber
    
    class func createInManagedObjectContext(moc:NSManagedObjectContext, amount:NSNumber, category:String, percentage:NSNumber) -> Request {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName(self.getName(), inManagedObjectContext: moc) as Request
        newItem.amount = amount
        newItem.category = category
        newItem.percentage = percentage
        return newItem
    }
    
    class func getName() -> String {
        return "Request"
    }
    
    class func convertPercentageToString(percentage:NSNumber) -> String {
        switch percentage {
        case 0.08:
            return "8%"
        case 0.10:
            return "10%"
        case 0.12:
            return "12%"
        case 0.15:
            return "15%"
        case 0.18:
            return "18%"
        case 0.20:
            return "20%"
        default:
            return "0%"
        }
    }

}
