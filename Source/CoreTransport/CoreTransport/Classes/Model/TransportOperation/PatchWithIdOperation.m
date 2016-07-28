//
//  PatchWithIdOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 23/09/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "PatchWithIdOperation.h"

@implementation PatchWithIdOperation

- (void)main
{
    if (self.cancelled) return;
    id result = [self.transport patchWithId:self.entityId 
                                 parameters:self.parameters];
    if (self.cancelled) return;
    self.transportCompletionBlock(result);
}

@end
