//
//  OpenSSLCrypto.h
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/27/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

#ifndef Testing_Crypto_OpenSSLCrypto_h
#define Testing_Crypto_OpenSSLCrypto_h

#import <Foundation/Foundation.h>

@interface AESXSTOpenSSL : NSObject

- (NSData*) encrypt: (NSData*)data;
- (NSData*) decrypt: (NSData*)data;

@end


@interface AES128OpenSSL : NSObject

- (NSData*) encrypt: (NSData*)data;
- (NSData*) decrypt: (NSData*)data;

@end

#endif
