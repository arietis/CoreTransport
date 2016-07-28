//
//  CreateAtEndpointOperation.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 23/09/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <CoreTransport/ParameterizedOperation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Операция для транспортного метода -createWithParameters:atEndpoint:.
 
 @see ParameterizedOperation
 */
@interface CreateAtEndpointOperation : ParameterizedOperation

- (instancetype)initWithEndpoint:(nullable NSString *)endpoint
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock NS_DESIGNATED_INITIALIZER;

+ (instancetype)operationWithEndpoint:(nullable NSString *)endpoint
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock;

@property (nonatomic, strong, readonly) NSString *endpoint;

@end

NS_ASSUME_NONNULL_END