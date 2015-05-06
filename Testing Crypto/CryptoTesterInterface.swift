//
//  CryptoTesterInterface.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/22/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import Foundation

protocol CryptoTester {
    var name: String { get set}
    func encrypt(data: NSData) -> NSData?
    func decrypt(data: NSData) -> NSData?
    
}

protocol AddPerfDataDelegate {
    func sendData(string: String, value: Double)
    func finished()
}

protocol Command {
    var tester: CryptoTester { get set }
    
    func execute()
    func test() -> NSData?
    func getData() -> NSData
    
    func whoAmI() ->String
}

class EncryptCommand : Command{
    var name = "Encrypt"
    var tester: CryptoTester
    var data: NSData
    init(tester: CryptoTester, data: NSData) {
        self.tester = tester
        self.data = data
    }
    
    func execute() {
        tester.encrypt(data)
    }
    
    func whoAmI() -> String {
        return "\(tester.name) : \(name)"
    }
    
    func test() -> NSData? {
        return tester.encrypt(data)
    }
    
    func getData() -> NSData {
        return data;
    }
    
}

class DecryptCommand : Command{
    var name = "Decrypt"
    var tester: CryptoTester
    var data: NSData
    init(tester: CryptoTester, data: NSData) {
        self.tester = tester
        self.data = data
    }
    
    func execute() {
        tester.decrypt(data)
    }
    
    func whoAmI() -> String {
        return "\(tester.name) : \(name)"
    }
    
    func test() -> NSData? {
        return tester.decrypt(data)
    }
    
    func getData() -> NSData {
        return data;
    }
    
}

class Executor {
    
    var delegate: AddPerfDataDelegate?
    
    init(delegate: AddPerfDataDelegate?) {
        self.delegate = delegate
    }
    
    var listOfCryptors = [Command]()
    
    func add(command: Command) {
        listOfCryptors.append(command)
    }
    
    func test(encryptor: Command, decryptor: Command) {
        
        let encVal = encryptor.test()
        let decrVal = decryptor.test()
        
        
    }
    
    func executeAll() {
        for exec in listOfCryptors {
                let startTime = NSDate()
                exec.execute()
                let finishTime = NSDate()
                let executionTime = finishTime.timeIntervalSinceDate(startTime)
                let normalizedTime = 1/(executionTime/1)
                self.delegate?.sendData("\(exec.whoAmI())", value: normalizedTime)
        }
        delegate?.finished()
    }
}