//
//  CookiePolicy.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 08.12.15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import "CookiePolicy.h"

@interface CookiePolicy ()
@property (nonatomic, readwrite, assign) NSHTTPCookieAcceptPolicy acceptPolicy;
@property (nonatomic, readwrite, strong) NSHTTPCookieStorage *storage;
@property (nonatomic, readwrite, assign) BOOL shouldSetAutomatically;
@end

@implementation CookiePolicy

- (instancetype)init
{
    return [self initWithAcceptPolicy:NSHTTPCookieAcceptPolicyNever
                              storage:nil
               shouldSetAutomatically:NO];
}

- (instancetype)initWithAcceptPolicy:(NSHTTPCookieAcceptPolicy)acceptPolicy
                             storage:(NSHTTPCookieStorage *)storage
              shouldSetAutomatically:(BOOL)shouldSetAutomatically
{
    if (self = [super init]) {
        self.acceptPolicy = acceptPolicy;
        self.storage = storage;
        self.shouldSetAutomatically = shouldSetAutomatically;
    }
    
    return self;
}

+ (instancetype)policy
{
    return [[self alloc] init];
}

+ (instancetype)policyWithAcceptPolicy:(NSHTTPCookieAcceptPolicy)acceptPolicy
                               storage:(NSHTTPCookieStorage *)storage
                shouldSetAutomatically:(BOOL)shouldSetAutomatically
{
    return [[self alloc] initWithAcceptPolicy:acceptPolicy
                                      storage:storage
                       shouldSetAutomatically:shouldSetAutomatically];
}

@end
