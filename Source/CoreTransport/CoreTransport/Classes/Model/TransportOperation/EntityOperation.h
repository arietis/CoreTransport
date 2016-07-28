//
//  EntityOperation.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <CoreTransport/ParameterizedOperation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Абстрактная операция, которая может быть совершена с модельной сущностью, руководствуясь 
 идентификатором этой сущности.
 
 Операция типа EntityOperation -- ничего не делает, но инкапсулирует информацию о предстоящем 
 запросе.
 */
@interface EntityOperation : ParameterizedOperation

/**
 Инициализатор.
 
 @param entityId        - идентификатор сущности;
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который должен быть вызван по окончанию операции. 
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
- (instancetype)initWithEntityId:(NSString *)entityId
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 
 @param entityId        - идентификатор сущности;
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который должен быть вызван по окончанию операции. 
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
+ (instancetype)operationWithEntityId:(NSString *)entityId
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock;

/**
 Идентификатор сущности, над которой необходимо произвести операцию.
 */
@property (nonatomic, strong, readonly) NSString *entityId;

@end

NS_ASSUME_NONNULL_END
