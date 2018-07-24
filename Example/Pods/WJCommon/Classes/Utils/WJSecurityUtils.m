//
//  WJSecurityUtils.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJSecurityUtils.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

@implementation WJSecurityUtils


+ (NSString *) stringFromDigest:(uint8_t *)digest length:(int)length {
    NSMutableString *ms = [[NSMutableString alloc] initWithCapacity:length * 2];
    for (int i = 0; i < length; i++) {
        [ms appendFormat: @"%02x", (int)digest[i]];
    }
    return [ms copy];
}

static const char sam_base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short sam_base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

+(NSString *)MD2:(NSData *)data {
    uint8_t digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_MD2_DIGEST_LENGTH];
}

+(NSString *)MD4:(NSData *)data {
    uint8_t digest[CC_MD4_DIGEST_LENGTH];
    CC_MD2(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_MD4_DIGEST_LENGTH];
}

+(NSString *)MD5:(NSData *)data {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_MD5_DIGEST_LENGTH];
}



+(NSString *)SHA1:(NSData*) data {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_SHA1_DIGEST_LENGTH];
}


+(NSString *)SHA224:(NSData*) data {
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_SHA224_DIGEST_LENGTH];
}


+(NSString *)SHA256:(NSData*) data {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_SHA256_DIGEST_LENGTH];
}


+(NSString *)SHA384:(NSData*) data {
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_SHA384_DIGEST_LENGTH];
}


+(NSString *)SHA512:(NSData*) data {
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    return [self stringFromDigest:digest length:CC_SHA512_DIGEST_LENGTH];
}


+(NSString *)hexadedimalString:(NSData*) data {
    NSMutableString *string = [NSMutableString string];
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    for (NSUInteger i = 0; i < length; i++) {
        [string appendFormat:@"%02x", bytes[i]];
    }
    return string;
}

+(NSString *)base64:(NSData *)dataAttr {
    const uint8_t *input = dataAttr.bytes;
    NSInteger length = dataAttr.length;
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] = sam_base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = sam_base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? sam_base64EncodingTable[(value >> 6) & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? sam_base64EncodingTable[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(NSData *)dataWithBase64:(NSString *)base64String {
    const char *string = [base64String cStringUsingEncoding:NSASCIIStringEncoding];
    NSInteger inputLength = base64String.length;
    
    if (string == NULL/* || inputLength % 4 != 0*/) {
        return nil;
    }
    
    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    uint8_t *output = data.mutableBytes;
    
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (sam_base64DecodingTable[(int)i0] << 2) | (sam_base64DecodingTable[(int)i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((sam_base64DecodingTable[(int)i1] & 0xf) << 4) | (sam_base64DecodingTable[(int)i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((sam_base64DecodingTable[(int)i2] & 0x3) << 6) | sam_base64DecodingTable[(int)i3];
        }
    }
    
    return data;
}

+ (NSString *) HMACMD5:(NSString*) content secretKey:(NSString*) secret {
    if (content) {
        
        CCHmacContext ctx;
        const char *key = [secret UTF8String];
        const char *str = [content UTF8String];
        unsigned char mac[CC_MD5_DIGEST_LENGTH];
        char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
        char *p;
        
        CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
        CCHmacUpdate(&ctx,str,strlen(str));
        CCHmacFinal(&ctx, mac);
        
        p = hexmac;
        for (int i=0; i < CC_MD5_DIGEST_LENGTH; i++) {
            snprintf(p, 3, "%02x",mac[i]);
            p += 2;
        }
        return [NSString stringWithUTF8String:hexmac];
    }
    return nil;
}

@end
