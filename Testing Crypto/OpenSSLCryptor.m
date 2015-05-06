//
//  OpenSSLCryptor.m
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/29/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

#import "OpenSSLCrypto.h"
#import <OpenSSL-Universal/openssl/evp.h>
#include <OpenSSL-Universal/openssl/aes.h>

@implementation OpenSSLCryptor

static EVP_CIPHER_CTX cipherCtx,decipherCtx;
static uint8_t iv[16];
static uint8_t encryptionKey[16];

- (void) setup: (int) mode {
    
    const EVP_CIPHER* cipherMode;
    
    switch (mode) {
        case 0: // cbc128
            cipherMode = EVP_aes_128_cbc();
            break;
        case 1: // ctr128
            cipherMode = EVP_aes_128_ctr();
            break;
        case 2: // xts
            cipherMode = EVP_aes_128_xts();
            break;
        case 3: // ofb
            cipherMode = EVP_aes_128_ofb();
            break;
        default:
            break;
    }
    
    EVP_EncryptInit_ex(&cipherCtx, cipherMode, NULL, encryptionKey, iv);
    EVP_DecryptInit_ex(&decipherCtx, cipherMode, NULL, encryptionKey, iv);
    
}

+ (void) initialize {
    arc4random_buf(&iv, 16);
    arc4random_buf(&encryptionKey, 16);
    EVP_CIPHER_CTX_init(&cipherCtx);
    EVP_CIPHER_CTX_init(&decipherCtx);
}

- (NSData*) encrypt: (NSData*)data {
    
    // pointers to data
    unsigned char *mData = (unsigned char *)[data bytes];
    int32_t mDataLen = (int)[data length];
    
    // output for data
    int32_t c_len = mDataLen + AES_BLOCK_SIZE, f_len = 0;
    unsigned char *ciphertext = malloc(c_len);
    
    EVP_EncryptInit_ex(&cipherCtx, NULL, NULL, NULL, NULL);
    EVP_EncryptUpdate(&cipherCtx, ciphertext, &c_len, mData, mDataLen);
    EVP_EncryptFinal_ex(&cipherCtx, ciphertext+c_len, &f_len);
    
    mDataLen = c_len + f_len;
    
    NSData *retVal = [NSData dataWithBytes:(const void *)ciphertext length:sizeof(unsigned char)*mDataLen];
    
    free(ciphertext);
    
    return retVal;
}

- (NSData*) decrypt: (NSData*)data {
    
    
    int32_t mDataLen = (int)[data length];
    unsigned char *mData = (unsigned char *)[data bytes];
    
    int32_t c_len = mDataLen + AES_BLOCK_SIZE, f_len = 0;
    unsigned char *ciphertext = malloc(c_len);
    
    EVP_DecryptInit_ex(&decipherCtx, NULL, NULL, NULL, NULL);
    EVP_DecryptUpdate(&decipherCtx, ciphertext, &c_len, mData, mDataLen);
    EVP_DecryptFinal_ex(&decipherCtx, ciphertext+c_len, &f_len);
    
    mDataLen = c_len + f_len;
    
    NSData *retVal = [NSData dataWithBytes:(const void *)ciphertext length:sizeof(unsigned char)*mDataLen];
    
    free(ciphertext);
    
    return retVal;
    
}


@end