//
//  EntityPropertyOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "EntityPropertyOperation.h"

@interface EntityPropertyOperation ()
@property (nonatomic, copy, readwrite) NSString *property;
@end

@implementation EntityPropertyOperation

- (instancetype)initWithEntityId:(NSString *)entityId
                        property:(NSString *)aProperty
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithEntityId:entityId
                             transport:transport
                            parameters:parameters
                            completion:completionBlock]) {
        self.property = aProperty;
    }

    return self;
}

+ (instancetype)operationWithEntityId:(NSString *)entityId
                             property:(NSString *)aProperty
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock
{
    return [[self alloc] initWithEntityId:entityId
                                 property:aProperty
                                transport:transport
                               parameters:parameters
                               completion:completionBlock];
}

@end
