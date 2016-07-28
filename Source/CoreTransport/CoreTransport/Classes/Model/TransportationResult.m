//
//  TransportationResult.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "TransportationResult.h"

@interface TransportationResult ()
@property (nonatomic, strong, readwrite) id object;
@property (nonatomic, strong, readwrite) NSError *error;
@end

@implementation TransportationResult

- (instancetype)initWithObject:(id)object error:(NSError *)error
{
    if (self = [super init]) {
        self.object = object;
        self.error  = error;
    }
    
    return self;
}

+ (instancetype)resultWithObject:(id)object error:(NSError *)error
{
    return [[self alloc] initWithObject:object error:error];
}

#pragma mark - NSObject

- (NSString *)description
{
    return [self debugDescription];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"\nOBJECT: %@\nERROR: %@", self.object, self.error];
}

@end
