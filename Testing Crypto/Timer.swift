//
//  Timer.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/22/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import Foundation
import CommonCrypto

class Timer {
    
    var delegate: AddPerfDataDelegate?

    
    func run(data: NSData) {
        delegate?.sendData("Starting testing...")
        var executor = Executor(delegate: delegate)
        
        let aes128 = CommonCryptoClass(name: "AES128")
        let blowFish = CommonCryptoClass(name: "BlowFish", withAlgoritm: UInt32(kCCAlgorithmBlowfish))
        let rc4 = CommonCryptoClass(name: "RC4", withAlgoritm: UInt32(kCCAlgorithmRC4))

        
        executor.add(EncryptCommand(tester: aes128, data: data))
        executor.add(DecryptCommand(tester: aes128, data: data))

        executor.add(EncryptCommand(tester: blowFish, data: data))
        executor.add(DecryptCommand(tester: blowFish, data: data))

        executor.add(EncryptCommand(tester: rc4, data: data))
        executor.add(DecryptCommand(tester: rc4, data: data))

        
        executor.executeAll()
        
    }
    
}