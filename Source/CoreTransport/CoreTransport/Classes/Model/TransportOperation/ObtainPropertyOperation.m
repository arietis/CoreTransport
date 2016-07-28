//
//  ObtainPropertyOperation.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "ObtainPropertyOperation.h"

#import "Transport.h"

@implementation ObtainPropertyOperation

- (void)main
{
    if (self.cancelled) return;
    id result = [self.transport obtainWithId:self.entityId
                                    property:self.property
                                  parameters:self.parameters];
    if (self.cancelled) return;
    self.transportCompletionBlock(result);
}

@end
