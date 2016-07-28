//
//  CoreTransport.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 04/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for CoreTransport.
FOUNDATION_EXPORT double CoreTransportVersionNumber;

//! Project version string for CoreTransport.
FOUNDATION_EXPORT const unsigned char CoreTransportVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CoreTransport/PublicHeader.h>

#import <CoreTransport/Transport.h>
#import <CoreTransport/WebTransport.h>
#import <CoreTransport/WebSocketTransport.h>
#import <CoreTransport/FileTransport.h>

// Helper

#import <CoreTransport/CookiePolicy.h>
#import <CoreTransport/SecurityPolicy.h>
#import <CoreTransport/JSONResponseSerializer.h>
#import <CoreTransport/WebTransportBuilder.h>

// Model

#import <CoreTransport/TransportationParameters.h>
#import <CoreTransport/TransportationResult.h>
#import <CoreTransport/TransportationError.h>

#import <CoreTransport/CreateAtEndpointOperation.h>
#import <CoreTransport/CreateOperation.h>
#import <CoreTransport/DeleteWithIdOperation.h>
#import <CoreTransport/EntityOperation.h>
#import <CoreTransport/EntityPropertyOperation.h>
#import <CoreTransport/ObtainAllOperation.h>
#import <CoreTransport/ObtainPropertyOperation.h>
#import <CoreTransport/ObtainWithIdOperation.h>
#import <CoreTransport/ParameterizedOperation.h>
#import <CoreTransport/PatchWithIdOperation.h>
#import <CoreTransport/TransportOperation.h>
#import <CoreTransport/UpdatePropertyOperation.h>
#import <CoreTransport/UpdateWithIdOperation.h>
#import <CoreTransport/SendFileOperation.h>
#import <CoreTransport/SendFileWithPartNameOperation.h>
