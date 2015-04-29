//
//  ViewController.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/20/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddPerfDataDelegate {

    @IBOutlet weak var outputText: UITextView!

    var currentlyRunningButton: UIButton?
    var running = false

    @IBAction func startTests(sender: UIButton) {
        if (running) {return}

        sender.enabled = false
        running = true
        
        currentlyRunningButton = sender
        outputText.text = ""

        switch sender.restorationIdentifier! {
        case "65kString":
            startTesting()
        case "5mFile":
            startTestingLargeFiles(5)
        case "30mFile":
            startTestingLargeFiles(30)
        default:
            break
        }

        
    }
    
    func startTestingWithData(data: NSData) {
        var timer = Timer()
        timer.delegate = self
        timer.run(data)
    }
    
    func startTesting() {
        let data = ("asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl34523452345345" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        startTestingWithData(data)
    }

    func startTestingLargeFiles(size: Int) {
        
        let file = size.description + "m"
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "zip")!
        
        let text1 = NSData(contentsOfFile: path)
        startTestingWithData(text1!)
        
    }

    
    func sendData(string: String) {
        outputText.text = outputText.text + string + "\r"
    }
    
    func finished() {
        currentlyRunningButton?.enabled = true
        running = false
    }

}

