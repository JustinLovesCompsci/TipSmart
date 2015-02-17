//
//  Util.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/17/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation

class Util {
    
    class func isEmptyString(str:NSString) -> Bool {
        return str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == ""
    }
    
    class func convertStringToPercentage(percent:String) -> Percentage {
        switch percent {
        case Percentage.Eight.description:
            return Percentage.Eight
        case Percentage.Ten.description:
            return Percentage.Ten
        case Percentage.Twelve.description:
            return Percentage.Twelve
        case Percentage.Fifteen.description:
            return Percentage.Fifteen
        case Percentage.Eighteen.description:
            return Percentage.Eighteen
        case Percentage.Twenty.description:
            return Percentage.Twenty
        default:
            return Percentage.Twenty
        }
    }
    
    class func convertNSNumberToString(percent:NSNumber) -> String {
        switch percent {
        case 0.08:
            return Percentage.Eight.description
        case 0.10:
            return Percentage.Ten.description
        case 0.12:
            return Percentage.Twelve.description
        case 0.15:
            return Percentage.Fifteen.description
        case 0.18:
            return Percentage.Eighteen.description
        case 0.20:
            return Percentage.Twenty.description
        default:
            return ""
        }
    }
    
    class func roundTwoDigits(value:NSNumber) -> NSNumber {
        var multiplier:Double = pow(10.0, 2)
        var answer:NSNumber = round(value.doubleValue * multiplier)/multiplier
        return answer
    }

}
