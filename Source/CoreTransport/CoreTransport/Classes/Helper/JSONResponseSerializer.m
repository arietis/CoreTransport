//
//  JSONResponseSerializer.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 10/15/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "JSONResponseSerializer.h"

NSString * const kJSONResponseSerializerDomain = @"JSONResponseSerializer";

NSString * const kNSJSONSerializationErrorKey  = @"JSONResponseSerializer.NSJSONSerializationError";
NSString * const kAFNetworkingErrorKey         = @"JSONResponseSerializer.AFNetworkingError";

@implementation JSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response 
                           data:(NSData *)data 
                          error:(NSError *__autoreleasing  _Nullable *)error
{
    NSError *httpError = nil;
    NSError *afnetworkingError = nil;
    NSError *bodySerializationError = nil;
    
    NSMutableDictionary *errorPayload = [[NSMutableDictionary alloc] init];
    
    id responseObject = [super responseObjectForResponse:response 
                                                    data:data
                                                   error:&afnetworkingError];
    
    if (!afnetworkingError) {
        return responseObject;
    } else {
        errorPayload[kAFNetworkingErrorKey] = afnetworkingError;
    }
    
    if (data && !responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:data 
                                                         options:NSJSONReadingAllowFragments 
                                                           error:&bodySerializationError];
        if (bodySerializationError) 
            errorPayload[kNSJSONSerializationErrorKey] = bodySerializationError;
    }
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        httpError = [self httpError:(NSHTTPURLResponse *)response];
    }
    
    NSInteger errorCode = httpError ? httpError.code : afnetworkingError.code;
    
    *error = [NSError errorWithDomain:kJSONResponseSerializerDomain
                                 code:errorCode
                             userInfo:errorPayload];
    
    return responseObject;
}

- (NSError *)httpError:(NSHTTPURLResponse *)response
{
    return [NSError errorWithDomain:kJSONResponseSerializerDomain 
                               code:response.statusCode 
                           userInfo:@{}];
}

@end
