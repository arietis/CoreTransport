//
//  TransportOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "TransportOperation.h"

@interface TransportOperation ()
@property (nonatomic, strong, readwrite) id <Transport> transport;
@property (nonatomic, strong, readwrite) TransportOperationCompletion transportCompletionBlock;
@end

@implementation TransportOperation

- (instancetype)initWithTransport:(id <Transport>)transport
                       completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super init]) {
        self.transport                = transport;
        self.transportCompletionBlock = completionBlock;
    }
    
    return self;
}

+ (instancetype)operationWithTransport:(id <Transport>)transport
                            completion:(TransportOperationCompletion)completionBlock
{
    return [[self alloc] initWithTransport:transport completion:completionBlock];
}

@end
