//
//  SecurityPolicy.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>
#import "SecurityPolicy.h"

#import "AssertMacros.h"

static BOOL AFServerTrustIsValid(SecTrustRef serverTrust)
{
    SecTrustResultType result;
    BOOL isValid = NO;

    __Require_noErr(SecTrustEvaluate(serverTrust, &result), _out);
    isValid = (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);

_out:
    return isValid;
}

@interface SecurityPolicy ()
@property (nonatomic, copy) NSString *certificateFingerprint;
@end

@implementation SecurityPolicy

- (instancetype)initWithCertificateFingerprint:(NSString *)fingerprint
{
    if (self = [super init]) {
        self.certificateFingerprint = fingerprint;
    }
    
    return self;
}

+ (instancetype)policyWithCertificateFingerprint:(NSString *)fingerprint
{
    return [[self alloc] initWithCertificateFingerprint:fingerprint];
}

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain
{
    if (![self checkDomainName:serverTrust domain:domain])
        return NO;

    // Проверка на "отпечаток пальца":
    SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
    if (serverCertificate == nil) return NO;

    NSString *certificateSha1 = [self hexStringValue:[self sha1:serverCertificate]];
    return [[certificateSha1 lowercaseString] isEqualToString:self.certificateFingerprint];

}

- (BOOL)checkDomainName:(SecTrustRef)serverTrust
                 domain:(NSString *)domain
{
    NSMutableArray *policies = [NSMutableArray array];
    [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)domain)];
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);
    return AFServerTrustIsValid(serverTrust);
}

- (NSString *)hexStringValue:(NSData *)data
{
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([data length] * 2)];

    const unsigned char *dataBuffer = [data bytes];

    for (int i = 0; i < [data length]; ++i)
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];

    return [stringBuffer copy];
}

- (NSData *)sha1:(SecCertificateRef)cert
{
    CFDataRef data = SecCertificateCopyData(cert);
    NSData *outData = [self SHA1Digest:[NSData dataWithBytes:CFDataGetBytePtr(data)
                                                      length:(NSUInteger)CFDataGetLength(data)]];
    CFRelease(data);
    return outData;
}

- (NSData *)SHA1Digest:(NSData *)data
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([data bytes], (CC_LONG)[data length], result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

@end
