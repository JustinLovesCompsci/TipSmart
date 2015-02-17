//
//  EditViewController.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditViewController:UIViewController {
    
    var attribute:Attribute = Attribute.Amount
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func confirmButton(sender: AnyObject) {
        var content:NSString = textField.text
        if validateAmount(content) {
            let fetchRequest = NSFetchRequest(entityName: Request.getName())
            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
                var request:Request = fetchResults[0];
                request.amount = content.doubleValue
            }
            self.parentViewController?.navigationController?.popViewControllerAnimated(true)
        } else {
            popUpAlertDialog("Oops...", message: "Amount entered is not a valid number!", buttonText: "Ok")
        }
    }
    
    func validateAmount(number:String) -> Bool {
        if Util.isEmptyString(number) {
            return false
        }
        var hasDots = false
        var numDigits = 0
        for char in number {
            if char == "." {
                if hasDots {
                    return false
                }
                hasDots = true
            }
            else if !isDigit(char) {
                return false
            } else {
                numDigits = numDigits + 1
            }
        }
        
        return numDigits > 1
    }
    
    func isDigit(char:Character) -> Bool {
        if char >= "0" && char <= "9" {
            return true
        }
        return false
    }
    
    func popUpAlertDialog(alert:String, message:String, buttonText:String){
        var alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch attribute {
        case Attribute.Amount:
            self.navigationItem.title = Attribute.Amount.description
        default:
            self.navigationItem.title = ""
        }
        textField.becomeFirstResponder()
    }
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    //set to only support portrait, too lazy to do the landscape
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}
