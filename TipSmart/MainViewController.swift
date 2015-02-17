//
//  MainViewController.swift
//  TipSmart
//
//  Created by Justin (Zihao) Zhang on 12/16/14.
//  Copyright (c) 2014 TipSmart. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let pictureItems = ["money", "category", "percentage"]
    @IBOutlet weak var tableView: UITableView!
    let attributeItems = [Attribute.Amount.description, Attribute.Category.description, Attribute.Percentage.description]
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBAction func calcButton(sender: AnyObject) {
        let fetchRequest = NSFetchRequest(entityName: Request.getName())
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
            var request:Request = fetchResults[0];
            var tip = Util.roundTwoDigits(request.amount.doubleValue * request.percentage.doubleValue).doubleValue
            tipAmount.text = tip.description
            var total:Double = Util.roundTwoDigits(tip + request.amount.doubleValue).doubleValue
            totalAmount.text = total.description
            NSLog("tip is " + tip.description + " and total is " + total.description)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributeItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("attributeCell") as UITableViewCell
        let row = indexPath.row
        var attribute = attributeItems[row]
        cell.textLabel?.text = attribute
        //        NSLog("cell for row called with indexPath " + indexPath.description + " and attribute" + attribute)
        let fetchRequest = NSFetchRequest(entityName: Request.getName())
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
            var request:Request = fetchResults[0];
            switch attribute {
            case Attribute.Amount.description:
                cell.detailTextLabel?.text = request.amount.stringValue
            case Attribute.Category.description:
                cell.detailTextLabel?.text = request.category
            case Attribute.Percentage.description:
                cell.detailTextLabel?.text = Request.convertPercentageToString(request.percentage)
            default:
                cell.detailTextLabel?.text = ""
            }
        }
        var image = UIImage(named: pictureItems[row])
        cell.imageView?.image = image
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var attribute = attributeItems[indexPath.row]
        NSLog("select row at attribute " + attribute)
        switch attribute {
        case Attribute.Amount.description:
            self.performSegueWithIdentifier("editAmount", sender: self)
        case Attribute.Category.description:
            self.performSegueWithIdentifier("selectCategory", sender: self)
        case Attribute.Percentage.description:
            self.performSegueWithIdentifier("selectPercentage", sender: self)
        default:
            break
        }
    }
    
    //the animation effect
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("Ready to launch segue from Main with name " + segue.identifier!)
        if segue.identifier == "editAmount" {
            var navController = segue.destinationViewController as UINavigationController
            var viewController = navController.viewControllers[0] as EditViewController
            viewController.attribute = Attribute.Amount
        } else if segue.identifier == "selectCategory" {
            var navController = segue.destinationViewController as UINavigationController
            var viewController = navController.viewControllers[0] as SelectViewController
            viewController.attribute = Attribute.Category
        } else if segue.identifier == "selectPercentage" {
            var navController = segue.destinationViewController as UINavigationController
            var viewController = navController.viewControllers[0] as SelectViewController
            viewController.attribute = Attribute.Percentage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        clearRequests()
        addNewRequest()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        clearAmount()
    }
    
    func clearAmount(){
        var tip:Double = 0
        tipAmount.text = tip.description
        var total:Double = 0
        totalAmount.text = total.description
    }
    
    //set to only support portrait, too lazy to do the landscape
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func clearRequests() {
        let fetchRequest = NSFetchRequest(entityName: Request.getName())
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Request] {
            for result in fetchResults {
                managedObjectContext?.deleteObject(result)
            }
        }
    }
    
    func addNewRequest() {
        var request = Request.createInManagedObjectContext(self.managedObjectContext!, amount: 00.00, category: Category.Casual_Restaurant.description, percentage: 0)
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
    
}