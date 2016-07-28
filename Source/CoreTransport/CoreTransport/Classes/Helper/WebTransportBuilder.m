//
//  WebTransportBuilder.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 11.01.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

#import "WebTransportBuilder.h"

#import <AFNetworking/AFNetworking.h>

#import <CoreTransport/CookiePolicy.h>
#import <CoreTransport/JSONResponseSerializer.h>
#import <CoreTransport/WebTransport.h>

@interface WebTransportBuilder () <WebTransportBuilder>
@property (nonatomic, readwrite, copy) NSString *serviceRoot;
@property (nonatomic, readwrite, strong) AFSecurityPolicy *securityPolicy;
@property (nonatomic, readwrite, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;
@property (nonatomic, readwrite, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;
@property (nonatomic, readwrite, copy) NSURLSessionConfiguration *sessionConfiguration;
@end

@implementation WebTransportBuilder

- (id <WebTransportBuilder>)initWithServiceRoot:(NSString *)serviceRoot
{
    if (self = [super init]) {
        self.serviceRoot = serviceRoot;

        self.securityPolicy       = [AFSecurityPolicy defaultPolicy];
        self.requestSerializer    = [AFJSONRequestSerializer serializer];
        self.responseSerializer   = [JSONResponseSerializer serializer];
        self.sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    }

    return self;
}


+ (id <WebTransportBuilder>)builderForServiceRoot:(NSString *)serviceRoot
{
    return [[self alloc] initWithServiceRoot:serviceRoot];
}

- (instancetype)withSecurityPolicy:(AFSecurityPolicy *)policy
{
    self.securityPolicy = policy;
    return self;
}

- (instancetype)withRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
{
    self.requestSerializer = requestSerializer;
    return self;
}

- (instancetype)withResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer
{
    self.responseSerializer = responseSerializer;
    return self;
}

- (instancetype)withCookiePolicy:(CookiePolicy *)policy
{
    self.sessionConfiguration.HTTPCookieAcceptPolicy = policy.acceptPolicy;
    self.sessionConfiguration.HTTPCookieStorage      = policy.storage;
    self.sessionConfiguration.HTTPShouldSetCookies   = policy.shouldSetAutomatically;
    return self;
}

- (instancetype)withSessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self.sessionConfiguration = configuration;
    return self;
}

- (WebTransport *)create
{
    return [[WebTransport alloc] initWithServiceRoot:self.serviceRoot
                                sessionConfiguration:self.sessionConfiguration
                                   requestSerializer:self.requestSerializer
                                  responseSerializer:self.responseSerializer
                                      securityPolicy:self.securityPolicy];
}

@end
