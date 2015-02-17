//
//  SelectViewController.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SelectViewController:UITableViewController {
    
    var attribute:Attribute = Attribute.Category
    var selectedAttribute:String = ""
    var selected = Dictionary<String, NSIndexPath>()
    let categoryItems = [Category.Casual_Restaurant.description, Category.High_End_Restaurant.description, Category.Delivery.description, Category.Taxi.description]
    let taxiItems = [Percentage.Twelve.description, Percentage.Fifteen.description, Percentage.Eighteen.description, Percentage.Twenty.description]
    let casualRestItems = [Percentage.Twelve.description, Percentage.Fifteen.description, Percentage.Eighteen.description]
    let highRestItems = [Percentage.Fifteen.description, Percentage.Eighteen.description, Percentage.Twenty.description]
    let deliveryItems = [Percentage.Eight.description, Percentage.Ten.description, Percentage.Twelve.description]
    let categoryPics = ["casual", "fullservice", "delivery", "taxi"]
    
    @IBAction func confirmButton(sender: AnyObject) {
        let fetchRequest = NSFetchRequest(entityName: Request.getName())
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
            var request:Request = fetchResults[0];
            switch attribute {
            case Attribute.Category:
                if request.category != selectedAttribute {
                    request.percentage = 0
                }
                request.category = selectedAttribute
            case Attribute.Percentage:
                request.percentage = Util.convertStringToPercentage(selectedAttribute).number
            default:
                break
            }
        }
        self.parentViewController?.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = attribute.description
        let fetchRequest = NSFetchRequest(entityName: Request.getName())
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
            var request:Request = fetchResults[0];
            switch attribute {
            case Attribute.Category:
                selectedAttribute = request.category
            case Attribute.Percentage:
                selectedAttribute = Util.convertNSNumberToString(request.percentage)
            default:
                break
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch attribute {
        case Attribute.Category:
            return categoryItems.count
        case Attribute.Percentage:
            let fetchRequest = NSFetchRequest(entityName: Request.getName())
            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
                var request:Request = fetchResults[0];
                switch request.category {
                case Category.Taxi.description:
                    return taxiItems.count
                case Category.Casual_Restaurant.description:
                    return casualRestItems.count
                case Category.High_End_Restaurant.description:
                    return highRestItems.count
                case Category.Delivery.description:
                    return deliveryItems.count
                default:
                    break
                }
            }
            return 0
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("choiceCell") as UITableViewCell
        let row = indexPath.row
        var choice = ""
        switch attribute {
        case Attribute.Category:
            choice = categoryItems[row]
            var image = UIImage(named: categoryPics[row])
            cell.imageView?.image = image
        case Attribute.Percentage:
            let fetchRequest = NSFetchRequest(entityName: Request.getName())
            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
                var request:Request = fetchResults[0];
                switch request.category {
                case Category.Taxi.description:
                    choice = taxiItems[row]
                case Category.Casual_Restaurant.description:
                    choice = casualRestItems[row]
                case Category.High_End_Restaurant.description:
                    choice = highRestItems[row]
                case Category.Delivery.description:
                    choice = deliveryItems[row]
                default:
                    break
                }
            }
        default:
            break
        }
        
        cell.textLabel?.text = choice
        if choice == selectedAttribute {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selected.updateValue(indexPath, forKey: choice)
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        if selectedAttribute != "" && selected[selectedAttribute] != nil {
            var prevSelected = tableView.cellForRowAtIndexPath(selected[selectedAttribute]!) as UITableViewCell!
            if prevSelected != nil {
                prevSelected.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        selectedAttribute = selectedCell.textLabel!.text!
        selected.removeAll(keepCapacity: false)
        selected.updateValue(indexPath, forKey: selectedAttribute)
        selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
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
