//
//  UpdateWithIdOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "UpdateWithIdOperation.h"

@implementation UpdateWithIdOperation

- (void)main
{
    if (self.cancelled) return;
    id result = [self.transport updateWithId:self.entityId 
                                  parameters:self.parameters];
    if (self.cancelled) return;
    self.transportCompletionBlock(result);
}

@end
