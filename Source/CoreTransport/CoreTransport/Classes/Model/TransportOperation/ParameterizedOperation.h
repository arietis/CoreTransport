//
//  ParameterizedOperation.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <CoreTransport/TransportOperation.h>

@class TransportationParameters;
@protocol Transport;

NS_ASSUME_NONNULL_BEGIN

/**
 Абстрактная операция, которая может совершить запрос с заданными параметрами.
 
 Операция типа ParameterizedOperation -- ничего не делает, но инкапсулирует информацию о параметрах
 предстоящего запроса.
 */
@interface ParameterizedOperation : TransportOperation

/**
 Инициализатор.
 
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
- (instancetype)initWithTransport:(id <Transport>)transport
                       parameters:(TransportationParameters *)parameters
                       completion:(TransportOperationCompletion)completionBlock NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
+ (instancetype)operationWithTransport:(id <Transport>)transport
                            parameters:(TransportationParameters *)parameters
                            completion:(TransportOperationCompletion)completionBlock;

/**
 Параметры, с которыми необходимо делать запрос.
 */
@property (nonatomic, copy, readonly) TransportationParameters *parameters;

@end

NS_ASSUME_NONNULL_END
