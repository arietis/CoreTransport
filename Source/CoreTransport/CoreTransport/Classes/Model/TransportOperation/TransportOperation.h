//
//  TransportOperation.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TransportationResult;
@protocol Transport;

NS_ASSUME_NONNULL_BEGIN

/**
 Блок, используемый транспортными операциями для возврата результата операции.
 
 @param result - результат выполнения транспортной операции. @see TransportationResult
 */
typedef void(^TransportOperationCompletion)(TransportationResult *result);

/**
 Абстрактная операция, использующая транспорт.
 
 Операции типа TransportOperation ничего не делают, но инкапсулируют информацию о транспорте, 
 который будет совершать запрос.
 */
@interface TransportOperation : NSOperation

- (instancetype)init NS_UNAVAILABLE;

/**
 Инициализатор.
 
 @param transport       - транспорт;
 @param completionBlock - блок, который необходимо вызвать по окончанию операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инциированный объект операции.
 */
- (instancetype)initWithTransport:(id <Transport>)transport
                       completion:(TransportOperationCompletion)completionBlock NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 
 @param transport       - транспорт;
 @param completionBlock - блок, который необходимо вызвать по окончанию операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инциированный объект операции. 
 */
+ (instancetype)operationWithTransport:(id <Transport>)transport
                            completion:(TransportOperationCompletion)completionBlock;

/**
 Транспорт.
 */
@property (nonatomic, strong, readonly) id <Transport> transport;

/**
 Блок, который будет вызван по окончанию операции.
 */
@property (nonatomic, strong, readonly) TransportOperationCompletion transportCompletionBlock;

@end

NS_ASSUME_NONNULL_END
