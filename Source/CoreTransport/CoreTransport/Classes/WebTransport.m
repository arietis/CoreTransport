//
//  WebTransport.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "WebTransport.h"
#import <AFNetworking/AFNetworking.h>

#import "CookiePolicy.h"
#import "JSONResponseSerializer.h"
#import "TransportationParameters.h"
#import "TransportationResult.h"
#import "SecurityPolicy.h"

NSString * const kTransportationResultKeyBody    = @"body";
NSString * const kTransportationResultKeyHeaders = @"headers";

@interface WebTransport ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy) NSString *serviceRoot;
@end

@implementation WebTransport

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
{
    return [self initWithServiceRoot:serviceRoot 
                      securityPolicy:[AFSecurityPolicy defaultPolicy]];
}

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                     securityPolicy:(AFSecurityPolicy *)policy
{
    return [self initWithServiceRoot:serviceRoot 
                   requestSerializer:[AFJSONRequestSerializer serializer] 
                  responseSerializer:[JSONResponseSerializer serializer] 
                      securityPolicy:policy];
}

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy
{
    return [self initWithServiceRoot:serviceRoot
                   requestSerializer:requestSerializer
                  responseSerializer:responseSerializer
                      securityPolicy:securityPolicy
                        cookiePolicy:[CookiePolicy policy]];
}

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy
                       cookiePolicy:(CookiePolicy *)cookiePolicy
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.HTTPCookieAcceptPolicy = cookiePolicy.acceptPolicy;
    configuration.HTTPCookieStorage      = cookiePolicy.storage;
    configuration.HTTPShouldSetCookies   = cookiePolicy.shouldSetAutomatically;
    
    return [self initWithServiceRoot:serviceRoot
                sessionConfiguration:configuration
                   requestSerializer:requestSerializer
                  responseSerializer:responseSerializer
                      securityPolicy:securityPolicy];
}

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
               sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy
{
    NSString *afServiceRoot = [serviceRoot substringToIndex:([serviceRoot length] - [[serviceRoot lastPathComponent] length])];
    self.serviceRoot = [serviceRoot lastPathComponent] ?: @"";
    
    if (self = [super init]) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:afServiceRoot]
                                                       sessionConfiguration:sessionConfiguration];
        requestSerializer.HTTPShouldHandleCookies = NO;
        self.sessionManager.requestSerializer  = requestSerializer;
        self.sessionManager.responseSerializer = responseSerializer;
        self.sessionManager.securityPolicy     = securityPolicy;
    }
    
    return self;
}

+ (instancetype)transportWithServiceRoot:(NSString *)serviceRoot
{
    return [[self alloc] initWithServiceRoot:serviceRoot];
}

#pragma mark - Transport

- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters
{
    return [self createWithParameters:parameters
                           atEndpoint:@""];
}

- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters
                                    atEndpoint:(nullable NSString *)endpoint
{
    endpoint = endpoint ?: @"create";

    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self assignHeaders:parameters.headers];
    [self.sessionManager POST:[self serviceRootWithEntityId:endpoint]
                   parameters:parameters.bodyParameters
                     progress:nil
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                          responseBody    = responseObject;
                          responseHeaders = httpResponse.allHeaderFields;

                          dispatch_semaphore_signal(semaphore);
                      }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                          responseHeaders = httpResponse.allHeaderFields;
                          responseError   = error;

                          dispatch_semaphore_signal(semaphore);
                      }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{ };
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{ };

    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject]
                                            error:responseError];
}

- (TransportationResult *)sendFile:(NSData *)fileData
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint
{
    return [self sendFile:fileData
               asBodyPart:@"file"
                 fileName:fileName
                 fileType:fileType
           withParameters:parameters
               atEndpoint:endpoint];
}

- (TransportationResult *)sendFile:(NSData *)fileData
                        asBodyPart:(NSString *)partName
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    void (^multipartFormData)(id <AFMultipartFormData>) = ^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData
                                    name:partName
                                fileName:fileName
                                mimeType:fileType];
    };
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager POST:[self serviceRootWithEntityId:endpoint]
                   parameters:parameters.bodyParameters
    constructingBodyWithBlock:multipartFormData
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                          responseBody    = responseObject;
                          responseHeaders = httpResponse.allHeaderFields;
                          
                          dispatch_semaphore_signal(semaphore);
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                          responseHeaders = httpResponse.allHeaderFields;
                          responseError   = error;
                          
                          dispatch_semaphore_signal(semaphore);
                      }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{ };
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{ };
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject]
                                            error:responseError];
}

- (TransportationResult *)obtainAllWithParameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self assignHeaders:parameters.headers];
    [self.sessionManager GET:self.serviceRoot
                  parameters:parameters.bodyParameters
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseBody    = responseObject;
                         responseHeaders = httpResponse.allHeaderFields;
                         
                         dispatch_semaphore_signal(semaphore);
                     } 
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseHeaders = httpResponse.allHeaderFields;
                         responseError   = error;
                         
                         dispatch_semaphore_signal(semaphore);
                     }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

- (TransportationResult *)obtainWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager GET:[self serviceRootWithEntityId:entityId]
                  parameters:parameters.bodyParameters
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseBody    = responseObject;
                         responseHeaders = httpResponse.allHeaderFields;
                         
                         dispatch_semaphore_signal(semaphore);
                     } 
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseHeaders = httpResponse.allHeaderFields;
                         responseError   = error;
                         
                         dispatch_semaphore_signal(semaphore);
                     }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

- (TransportationResult *)obtainWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager GET:[[self serviceRootWithEntityId:entityId] stringByAppendingFormat:@"/%@", property]
                  parameters:parameters.bodyParameters
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseBody    = responseObject;
                         responseHeaders = httpResponse.allHeaderFields;
                         
                         dispatch_semaphore_signal(semaphore);
                     } 
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseHeaders = httpResponse.allHeaderFields;
                         responseError   = error;
                         
                         dispatch_semaphore_signal(semaphore);
                     }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

- (TransportationResult *)updateWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager PUT:[self serviceRootWithEntityId:entityId]
                  parameters:parameters.bodyParameters 
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseBody    = responseObject;
                         responseHeaders = httpResponse.allHeaderFields;
                         
                         dispatch_semaphore_signal(semaphore);
                     } 
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                         responseHeaders = httpResponse.allHeaderFields;
                         responseError   = error;
                         
                         dispatch_semaphore_signal(semaphore);
                     }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

- (TransportationResult *)patchWithId:(NSString *)entityId 
                           parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager PATCH:[self serviceRootWithEntityId:entityId]
                    parameters:parameters.bodyParameters 
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                           responseBody    = responseObject;
                           responseHeaders = httpResponse.allHeaderFields;
                           
                           dispatch_semaphore_signal(semaphore);
                       } 
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                           responseHeaders = httpResponse.allHeaderFields;
                           responseError   = error;
                           
                           dispatch_semaphore_signal(semaphore);
                       }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

- (TransportationResult *)updateWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager PATCH:[[self serviceRootWithEntityId:entityId] stringByAppendingFormat:@"/%@", property]
                    parameters:parameters.bodyParameters 
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                           responseBody    = responseObject;
                           responseHeaders = httpResponse.allHeaderFields;
                           
                           dispatch_semaphore_signal(semaphore);
                       } 
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                           responseHeaders = httpResponse.allHeaderFields;
                           responseError   = error;
                           
                           dispatch_semaphore_signal(semaphore);
                       }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];

}

- (TransportationResult *)deleteWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    NSDictionary __block *responseBody    = nil;
    NSDictionary __block *responseHeaders = nil;
    NSError      __block *responseError   = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self assignHeaders:parameters.headers];
    [self.sessionManager DELETE:[self serviceRootWithEntityId:entityId]
                     parameters:parameters.bodyParameters 
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                            responseBody    = responseObject;
                            responseHeaders = httpResponse.allHeaderFields;
                            
                            dispatch_semaphore_signal(semaphore);
                        } 
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                            responseHeaders = httpResponse.allHeaderFields;
                            responseError   = error;
                            
                            dispatch_semaphore_signal(semaphore);
                        }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSMutableDictionary *resultObject = [[NSMutableDictionary alloc] init];
    resultObject[kTransportationResultKeyHeaders] = responseHeaders ?: @{};
    resultObject[kTransportationResultKeyBody]    = responseBody ?: @{};
    
    return [TransportationResult resultWithObject:[NSDictionary dictionaryWithDictionary:resultObject] 
                                            error:responseError];
}

#pragma mark - Частные методы

- (void)assignHeaders:(NSDictionary *)headers
{
    for (NSString *header in headers.allKeys) {
        NSString *headerValue = headers[header];
        [self.sessionManager.requestSerializer setValue:headerValue 
                                     forHTTPHeaderField:header];
    }
}

- (NSString *)serviceRootWithEntityId:(NSString *)entityId
{
    if ([entityId isEqualToString:@""]) {
        return self.serviceRoot;
    }
    return [self.serviceRoot stringByAppendingFormat:@"/%@", entityId];
}

@end
