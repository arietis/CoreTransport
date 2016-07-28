//
//  CreateAtEndpointOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 23/09/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "CreateAtEndpointOperation.h"

#import <CoreTransport/Transport.h>

@interface CreateAtEndpointOperation ()
@property (nonatomic, strong) NSString *endpoint;
@end

@implementation CreateAtEndpointOperation

- (instancetype)initWithTransport:(id <Transport>)transport
                       parameters:(TransportationParameters *)parameters
                       completion:(TransportOperationCompletion)completionBlock
{
    return [self initWithEndpoint:@""
                        transport:transport
                       parameters:parameters
                       completion:completionBlock];
}

- (instancetype)initWithEndpoint:(NSString *)endpoint
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithTransport:transport
                             parameters:parameters
                             completion:completionBlock]) {
        self.endpoint = endpoint ?: @"create";
    }

    return self;
}

+ (instancetype)operationWithEndpoint:(nullable NSString *)endpoint
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock
{
    return [[self alloc] initWithEndpoint:endpoint
                                transport:transport
                               parameters:parameters
                               completion:completionBlock];
}

- (void)main
{
    if (self.cancelled) return;
    id result = [self.transport createWithParameters:self.parameters atEndpoint:self.endpoint];
    if (self.cancelled) return;
    self.transportCompletionBlock(result);
}

@end
