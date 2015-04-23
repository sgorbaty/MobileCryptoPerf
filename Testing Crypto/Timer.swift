//
//  Timer.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/22/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import Foundation

class Timer {
    
    var delegate: AddPerfDataDelegate?

    
    func run(data: NSData) {
        delegate?.sendData("Starting testing...")
        var executor = Executor(delegate: delegate)
        
        executor.add(EncryptCommand(tester: CommonCryptoClass(), data: data))
        executor.add(DecryptCommand(tester: CommonCryptoClass(), data: data))
        
        executor.executeAll()
        
    }
    
}