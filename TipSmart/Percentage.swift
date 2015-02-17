//
//  Percentage.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation

enum Percentage {
    case Eight
    case Ten
    case Twelve
    case Fifteen
    case Eighteen
    case Twenty
    
    var description:String {
        switch self {
        case .Eight:
            return "8%"
        case .Ten:
            return "10%"
        case .Twelve:
            return "12%"
        case .Fifteen:
            return "15%"
        case .Eighteen:
            return "18%"
        case .Twenty:
            return "20%"
        }
    }
    
    var number:NSNumber {
        switch self {
        case .Eight:
            return 0.08
        case .Ten:
            return 0.10
        case .Twelve:
            return 0.12
        case .Fifteen:
            return 0.15
        case .Eighteen:
            return 0.18
        case .Twenty:
            return 0.20
        }
    }
    
}