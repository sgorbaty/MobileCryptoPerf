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
        var executor = Executor(delegate: delegate)
        let aes128 = CommonCryptoClass(name: "AES128 CBC - CC")
        let rc4 = CommonCryptoClass(name: "AES128 RC4 - CC", withAlgoritm: UInt32(kCCAlgorithmAES128))
        
        let aesCBC = AESOpenSSLClass(name: "AES128 CBC")
        let aesCTR = AESOpenSSLClass(name: "AES128 CTR", withMode: 1)
        let aesXts = AESOpenSSLClass(name: "AES128 XTS", withMode: 2)
        
        
        var encrVal = aes128.encrypt(data)
        executor.add(CommandImpl(name: "Encrypt", tester: aes128, data: data))
        executor.add(CommandImpl(name: "Decrypt", tester: aes128, data: encrVal!))
        
        let encrValrc4 = rc4.encrypt(data)
        executor.add(CommandImpl(name: "Encrypt", tester: rc4, data: data))
        executor.add(CommandImpl(name: "Decrypt", tester: rc4, data: encrValrc4!))
        
        let encrValCBC = aesCBC.encrypt(data)
        executor.add(CommandImpl(name: "Encrypt", tester: aesCBC, data: data))
        executor.add(CommandImpl(name: "Decrypt", tester: aesCBC, data: encrValCBC!))
        
        let encrValCTR = aesCTR.encrypt(data)
        executor.add(CommandImpl(name: "Encrypt", tester: aesCTR, data: data))
        executor.add(CommandImpl(name: "Decrypt", tester: aesCTR, data: encrValCTR!))
        
        let encrValXTS = aesXts.encrypt(data)
        executor.add(CommandImpl(name: "Encrypt", tester: aesXts, data: data))
        executor.add(CommandImpl(name: "Decrypt", tester: aesXts, data: encrValXTS!))
        
        
        executor.executeAll()
        
    }
    
}