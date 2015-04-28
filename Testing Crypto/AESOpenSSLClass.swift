//
//  AESOpenSSLClass.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/27/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import Foundation

class AESOpenSSLClass : CryptoTester {
    
    var name = String()
    let aesCrypto = AESXSTOpenSSL()
    
    init (name: String) {
        self.name = name
    }

    
    func encrypt(someData: NSData) -> NSData? {
        return aesCrypto.encrypt(someData)
    }
    
    func decrypt(someData: NSData) -> NSData? {
        return aesCrypto.decrypt(someData)
    }

    
}