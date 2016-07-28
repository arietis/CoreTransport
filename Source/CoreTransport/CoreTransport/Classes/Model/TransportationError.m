// 
// TransportationError.m
// AppCode
// 
// Created by Egor Taflanidi on 10/6/2015 AD.
// Copyright (c) 2015 RedMadRobot LLC. All rights reserved.
//

#import "TransportationError.h"

NSString * const kCoreTransportDomain = @"CoreTransport";

NSInteger const kCoreTransportErrorOperationNotSupported = 501;

@implementation TransportationError

+ (instancetype)errorOperationNotSupported
{
    return [TransportationError errorWithDomain:kCoreTransportDomain
                                           code:kCoreTransportErrorOperationNotSupported
                                       userInfo:@{}];
}

@end