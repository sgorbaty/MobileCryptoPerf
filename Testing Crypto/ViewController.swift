//
//  ViewController.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/20/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddPerfDataDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var outputTable: UITableView!
    
    var currentlyRunningButton: UIButton?
    
    var dictItems = [Double: String]()

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.outputTable.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        var keys = self.dictItems.keys.array.sorted(>)
        var key = keys[indexPath.row]

        cell.textLabel?.text =  String (format:" \(self.dictItems[key]!) %.2f", key)
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("You selected cell #\(indexPath.row)!")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outputTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func startTests(sender: UIButton) {
        sender.enabled = false
        currentlyRunningButton = sender
        dictItems.removeAll()
     
        switch sender.restorationIdentifier! {
        case "64bString":
            startTestingString(StringSize.SIZE64)
        case "128bString":
            startTestingString(StringSize.SIZE128)
        case "5mFile":
            startTestingLargeFiles(5)
        case "30mFile":
            startTestingLargeFiles(30)
        default:
            break
        }

    }
    
    enum StringSize : String {
        case SIZE64 = "asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl34523452345345"
        case SIZE128 = "asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl34523452345345asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl34523452345345"
    }
    
    
    func startTestingWithData(data: NSData) {
        var timer = Timer()
        timer.delegate = self
        timer.run(data)
    }
    
    func startTestingString(size: StringSize) {
        let data = (size.rawValue as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        startTestingWithData(data)
    }

    func startTestingLargeFiles(size: Int) {
        
        let file = size.description + "m"
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "zip")!
        
        let text1 = NSData(contentsOfFile: path)
        startTestingWithData(text1!)
        
    }

    func sendData(name: String, value: Double) {
        dictItems[value]=name;
    }


    func finished() {
        currentlyRunningButton?.enabled = true
        self.outputTable.reloadData()
    }

}

