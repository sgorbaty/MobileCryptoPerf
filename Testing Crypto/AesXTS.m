//
//  AesXTS.m
//  Testing Crypto
//
//  Created by Sergey Gorbaty on 4/27/15.
//  Copyright (c) 2015 Sergey Gorbaty. All rights reserved.
//

#import "OpenSSLCrypto.h"
#import <OpenSSL-Universal/openssl/evp.h>
#include <OpenSSL-Universal/openssl/aes.h>


@implementation AESXSTOpenSSL

static EVP_CIPHER_CTX cipherCtx,decipherCtx;
static uint8_t iv[16];
static uint8_t encryptionKey[16];

+ (void) initialize {
    arc4random_buf(&iv, 16);
    arc4random_buf(&encryptionKey, 16);
    EVP_CIPHER_CTX_init(&cipherCtx);
    EVP_CIPHER_CTX_init(&decipherCtx);

    EVP_EncryptInit_ex(&cipherCtx, EVP_aes_256_cbc(), NULL, encryptionKey, iv);
    EVP_DecryptInit_ex(&decipherCtx, EVP_aes_256_cbc(), NULL, encryptionKey, iv);
    
}

- (NSData*) encrypt: (NSData*)data {
    
    // pointers to data
    unsigned char *mData = (unsigned char *)[data bytes];
    int mDataLen = [data length];
    
    // output for data
    size_t c_len = mDataLen + AES_BLOCK_SIZE, f_len = 0;
    unsigned char *ciphertext = malloc(c_len);
    
    EVP_EncryptInit_ex(&cipherCtx, NULL, NULL, NULL, NULL);
    EVP_EncryptUpdate(&cipherCtx, ciphertext, &c_len, mData, mDataLen);
    EVP_EncryptFinal_ex(&cipherCtx, ciphertext+c_len, &f_len);
    
    mDataLen = c_len + f_len;
    
    return [NSData dataWithBytes:(const void *)ciphertext length:sizeof(unsigned char)*mDataLen];
    
}

- (NSData*) decrypt: (NSData*)data {
    
    
    int mDataLen = [data length];
    unsigned char *mData = (unsigned char *)[data bytes];
    
    
    
    size_t c_len = mDataLen + AES_BLOCK_SIZE, f_len = 0;
    unsigned char *ciphertext = malloc(c_len);
    
    EVP_DecryptInit_ex(&decipherCtx, NULL, NULL, NULL, NULL);
    EVP_DecryptUpdate(&decipherCtx, ciphertext, &c_len, mData, mDataLen);
    EVP_DecryptFinal_ex(&decipherCtx, ciphertext+c_len, &f_len);
    
    mDataLen = c_len + f_len;
    
    return [NSData dataWithBytes:(const void *)ciphertext length:sizeof(unsigned char)*mDataLen];
    

}


@end