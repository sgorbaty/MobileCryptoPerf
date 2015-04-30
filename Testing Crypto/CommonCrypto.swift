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
    var name = String()
    var algoritm = CCAlgorithm()
    
    init (name: String, withAlgoritm algoritm: CCAlgorithm = UInt32(kCCAlgorithmAES128)) {
        self.name = name
        self.algoritm = algoritm
    }

    static let secretkey = NSMutableData(length: kCCBlockSizeAES128)!
    static let secretKeyData = SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, UnsafeMutablePointer<UInt8>(secretkey.mutableBytes))
    static let iv = NSMutableData(length: kCCBlockSizeAES128)!
    static let randomRes = SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, UnsafeMutablePointer<UInt8>(iv.mutableBytes))
    static let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)

    
    func encrypt(someData: NSData) -> NSData? {
        return cryptInternal(someData, method: algoritm, operation: UInt32(kCCEncrypt))
    }
    
    func decrypt(someData: NSData) -> NSData? {
        return cryptInternal(someData, method: algoritm, operation: UInt32(kCCDecrypt))
    }
    
    func cryptInternal(someData: NSData, method algoritm: CCAlgorithm, operation: CCOperation) -> NSData?{
        var bufferData    = NSMutableData(length: someData.length + kCCBlockSizeAES128)!
        var numBytesEncrypted: Int = 0
        
        let cryptStatus = CCCrypt(operation, algoritm, CommonCryptoClass.options,
            CommonCryptoClass.secretkey.bytes, kCCBlockSizeAES128,
            CommonCryptoClass.iv.bytes,
            someData.bytes, someData.length,
            bufferData.mutableBytes, bufferData.length,
            &numBytesEncrypted)

        bufferData.length = numBytesEncrypted
        return bufferData
    }
}