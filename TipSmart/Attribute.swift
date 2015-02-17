//
//  Attribute.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation

enum Attribute {
    case Amount
    case Category
    case Percentage
    
    var description:String {
        switch self {
        case .Amount:
            return "Amount"
        case .Category:
            return "Category"
        case .Percentage:
            return "Percentage"
        }
    }
}