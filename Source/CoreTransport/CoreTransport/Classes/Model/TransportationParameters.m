//
//  TransportationParameters.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "TransportationParameters.h"

static NSString * const kTransportationParametersKeyBody    = @"body_parameters";
static NSString * const kTransportationParametersKeyHeaders = @"headers";

static NSString * const kTransportationParametersHeaderCookie = @"Cookie";
static NSString * const kTransportationParametersHeaderAuthorization = @"Authorization";

@interface TransportationParameters ()
@property (nonatomic, copy, readwrite) NSDictionary *bodyParameters;
@property (nonatomic, copy, readwrite) NSDictionary *headers;
@end

@implementation TransportationParameters

- (instancetype)init
{
    if (self = [super init]) {
        self.bodyParameters = @{};
        self.headers        = @{};
    }
    
    return self;
}

+ (instancetype)emptyParameters
{
    return [[self alloc] init];
}

- (instancetype)withObject:(id)object forKey:(NSString *)key
{
    NSMutableDictionary *parameters = [self.bodyParameters mutableCopy];
    parameters[key] = object;
    self.bodyParameters = [NSDictionary dictionaryWithDictionary:parameters];
    
    return self;
}

+ (instancetype)withObject:(id)object forKey:(NSString *)key
{
    return [[[self alloc] init] withObject:object forKey:key];
}

- (instancetype)withHeader:(NSString *)header value:(NSString *)value
{
    NSMutableDictionary *headers = [self.headers mutableCopy];
    headers[header] = value;
    self.headers = [NSDictionary dictionaryWithDictionary:headers];
    
    return self;
}

+ (instancetype)withHeader:(NSString *)header value:(NSString *)value
{
    return [[[self alloc] init] withHeader:header value:value];
}

- (instancetype)withCookie:(NSString *)cookie value:(NSString *)value
{
    NSMutableString *cookies = [self.headers[kTransportationParametersHeaderCookie] mutableCopy];
    cookies = cookies ?: [[NSMutableString alloc] init];
    
    [cookies appendFormat:@"%@=%@; ", cookie, value];
    return [self withHeader:kTransportationParametersHeaderCookie value:[NSString stringWithString:cookies]];
}

+ (instancetype)withCookie:(NSString *)cookie value:(NSString *)value
{
    return [[[self alloc] init] withCookie:cookie value:value];
}

- (instancetype)withHttpAuth:(NSString *)value
{
    NSMutableString *auth = [self.headers[kTransportationParametersHeaderAuthorization] mutableCopy];
    auth = auth ?: [[NSMutableString alloc] init];
    
    [auth appendFormat:@"%@", value];
    return [self withHeader:kTransportationParametersHeaderAuthorization value:[NSString stringWithString:auth]];
}

+ (instancetype)withHttpAuth:(NSString *)value
{
    return [[[self alloc] init] withHttpAuth:value];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    typeof(self) copy = [[[self class] alloc] init];

    copy.bodyParameters = self.bodyParameters;
    copy.headers        = self.headers;

    return copy;
}

- (NSUInteger)hash
{
    return [self.bodyParameters hash] * [self.headers hash];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.bodyParameters = [aDecoder decodeObjectForKey:kTransportationParametersKeyBody];
        self.headers        = [aDecoder decodeObjectForKey:kTransportationParametersKeyHeaders];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bodyParameters forKey:kTransportationParametersKeyBody];
    [aCoder encodeObject:self.headers forKey:kTransportationParametersKeyHeaders];
}

+ (BOOL)supportsSecureCoding { return YES; }

@end
