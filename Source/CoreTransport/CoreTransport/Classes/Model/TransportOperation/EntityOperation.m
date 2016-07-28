//
//  EntityOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "EntityOperation.h"

@interface EntityOperation ()
@property (nonatomic, strong, readwrite) NSString *entityId;
@end

@implementation EntityOperation

- (instancetype)initWithTransport:(id <Transport>)transport
                       parameters:(TransportationParameters *)parameters
                       completion:(TransportOperationCompletion)completionBlock
{
    return [self initWithEntityId:@""
                        transport:transport
                       parameters:parameters
                       completion:completionBlock];
}


- (instancetype)initWithEntityId:(NSString *)entityId
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithTransport:transport
                             parameters:parameters
                             completion:completionBlock]) {
        self.entityId = entityId;
    }

    return self;
}

+ (instancetype)operationWithEntityId:(NSString *)entityId
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock
{
    return [[self alloc] initWithEntityId:entityId
                                transport:transport
                               parameters:parameters
                               completion:completionBlock];
}

@end
