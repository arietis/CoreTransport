//
//  ParameterizedOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "ParameterizedOperation.h"

#import "TransportationParameters.h"

@interface ParameterizedOperation ()
@property (nonatomic, copy, readwrite) TransportationParameters *parameters;
@end

@implementation ParameterizedOperation

- (instancetype)initWithTransport:(id <Transport>)transport
                       completion:(TransportOperationCompletion)completionBlock
{
    return [self initWithTransport:transport
                        parameters:[[TransportationParameters emptyParameters] withHttpAuth:@"Basic YWdpbWE6RzRlNFI2bzM="]
                        completion:completionBlock];
}

- (instancetype)initWithTransport:(id <Transport>)transport
                       parameters:(TransportationParameters *)parameters
                       completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithTransport:transport completion:completionBlock]) {
        self.parameters = [parameters withHttpAuth:@"Basic YWdpbWE6RzRlNFI2bzM="];
    }
    
    return self;
}

+ (instancetype)operationWithTransport:(id <Transport>)transport
                            parameters:(TransportationParameters *)parameters
                            completion:(TransportOperationCompletion)completionBlock
{
    return [[self alloc] initWithTransport:transport
                                parameters:[parameters withHttpAuth:@"Basic YWdpbWE6RzRlNFI2bzM="]
                                completion:completionBlock];
}

@end
