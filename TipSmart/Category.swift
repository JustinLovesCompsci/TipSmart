//
//  Category.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation

enum Category {
    case Taxi
    case Casual_Restaurant
    case High_End_Restaurant
    case Delivery
    
    var description:String {
        switch self {
        case .Taxi:
            return "Taxi"
        case .Casual_Restaurant:
            return "Casual Dining"
        case .High_End_Restaurant:
            return "Full Service Restaurant"
        case .Delivery:
            return "Delivery"
        }
    }
    
}