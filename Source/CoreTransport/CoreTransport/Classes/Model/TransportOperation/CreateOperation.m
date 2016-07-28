//
//  CreateOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "CreateOperation.h"

#import "Transport.h"

@implementation CreateOperation

- (void)main
{
    if (self.cancelled) return;
    id result = [self.transport createWithParameters:self.parameters];
    if (self.cancelled) return;
    self.transportCompletionBlock(result);
}

@end
