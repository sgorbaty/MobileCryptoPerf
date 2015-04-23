//
//  CommonCrypto.swift
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/21/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

import Foundation
import CommonCrypto


class CommonCryptoClass : CryptoTester{
    var name = "CommonCrypto AES 128"

    static let secretkey = "tomafdfsdfcat"
    static let secretKeyData = secretkey.dataUsingEncoding(NSUTF8StringEncoding)!
    static let iv = NSMutableData(length: kCCBlockSizeAES128)!
    static let randomRes = SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, UnsafeMutablePointer<UInt8>(iv.mutableBytes))
    static let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
    static let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)

    
    func encrypt(someData: NSData) -> NSData{
        var bufferData    = NSMutableData(length: someData.length + kCCBlockSizeAES128)!
        let operation: CCOperation = UInt32(kCCEncrypt)
        var numBytesEncrypted: Int = 0
        
        var cryptStatus = CCCrypt(operation, CommonCryptoClass.algoritm, CommonCryptoClass.options,
            CommonCryptoClass.secretKeyData.bytes, kCCBlockSizeAES128,
            CommonCryptoClass.iv.bytes,
            someData.bytes, someData.length,
            bufferData.mutableBytes, bufferData.length,
            &numBytesEncrypted)

        if (cryptStatus == 0) {
            bufferData.length = numBytesEncrypted
            return bufferData
        } else {
            println("Error: \(cryptStatus)")
            return NSData()
        }
    }
    
    func decrypt(someData: NSData) -> NSData{
        var bufferData    = NSMutableData(length: someData.length + kCCBlockSizeAES128)!
        let operation: CCOperation = UInt32(kCCDecrypt)
        var numBytesEncrypted: Int = 0
        
        var cryptStatus = CCCrypt(operation, CommonCryptoClass.algoritm, CommonCryptoClass.options,
            CommonCryptoClass.secretKeyData.bytes, kCCBlockSizeAES128,
            CommonCryptoClass.iv.bytes,
            someData.bytes, someData.length, // encrypted data
            bufferData.mutableBytes, bufferData.length,
            &numBytesEncrypted)
        
        if (cryptStatus == 0) {
            bufferData.length = numBytesEncrypted
            return bufferData
        } else {
            println("Error: \(cryptStatus)")
            return NSData()
        }
    }

}