//
//  JSONResponseSerializer.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 10/15/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString * const kJSONResponseSerializerDomain;

extern NSString * const kNSJSONSerializationErrorKey;
extern NSString * const kAFNetworkingErrorKey;

/**
 Класс, позволяющий доставать ошибки из ответов сервера при HTTP статусе, отличном от 2ХХ.
 */
@interface JSONResponseSerializer : AFJSONResponseSerializer
@end
