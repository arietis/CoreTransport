//
//  EntityPropertyOperation.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <CoreTransport/EntityOperation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Абстрактная операция, которая может быть совершена над свойством модельной сущности, руководствуясь
 идентификатором этой сущности и названием свойства этой сущности.
 
 Операция EntityPropertyOperation -- ничего не делает, но инкапсулирует информацию о предстоящем
 запросе.
 */
@interface EntityPropertyOperation : EntityOperation

/**
 Инициализатор.
 
 @param entityId        - идентификатор сущности;
 @param aProperty       - название свойства сущности;
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
- (instancetype)initWithEntityId:(NSString *)entityId
                        property:(NSString *)aProperty
                       transport:(id <Transport>)transport
                      parameters:(TransportationParameters *)parameters
                      completion:(TransportOperationCompletion)completionBlock;

/**
 Фабричный метод.
 
 @param entityId        - идентификатор сущности;
 @param aProperty       - название свойства сущности;
 @param transport       - транспорт;
 @param parameters      - параметры запроса;
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
+ (instancetype)operationWithEntityId:(NSString *)entityId
                             property:(NSString *)aProperty
                            transport:(id <Transport>)transport
                           parameters:(TransportationParameters *)parameters
                           completion:(TransportOperationCompletion)completionBlock;

/**
 Название свойства модельной сущности, над которым необходимо провести операцию.
 */
@property (nonatomic, copy, readonly) NSString *property;

@end

NS_ASSUME_NONNULL_END
