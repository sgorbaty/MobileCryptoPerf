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

        switch sender.currentTitle! {
        case "65K String":
            startTesting()
            
        case "20MB Files":
            startTestingLargeFiles()
        default:
            break
        }

        
    }
    
    
    
    func startTesting() {
        let data = ("asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        var timer = Timer()
        timer.delegate = self
        timer.run(data)
        
    }

    func startTestingLargeFiles() {
        let data = ("asdfasdfasdfasdfasdfasdbahhkjhlkjhlkjhlkjhlkhlkjhl" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        var timer = Timer()
        timer.delegate = self
        timer.run(data)
        
    }

    
    func sendData(string: String) {
        outputText.text = outputText.text + string + "\r"
    }
    
    func finished() {
        outputText.text = outputText.text + "Finished"
        currentlyRunningButton?.enabled = true
        running = false
    }

}

