//
//  TransportationResult.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Объект, используемый для передачи результатов выполнения операции.
 */
@interface TransportationResult : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 Инициализатор.
 
 @param object - объект, который был получен в результате выполнения операции; обычно NSDictionary, 
 NSArray или NSData.
 @param error  - ошибка, возникшая в результате выполнения операции.
 
 @return Возвращает инициированный объект-результат выполнения операции.
 */
- (instancetype)initWithObject:(nullable id)object
                         error:(nullable NSError *)error NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 
 @param object - объект, который был получен в результате выполнения операции; обычно NSDictionary, 
 NSArray или NSData.
 @param error  - ошибка, возникшая в результате выполнения операции.
 
 @return Возвращает инициированный объект-результат выполнения операции.
 */
+ (instancetype)resultWithObject:(nullable id)object
                           error:(nullable NSError *)error;

/**
 Объект, полученный в результате выполнения операции.
 Обычно NSDictionary, NSArray или NSData.
 */
@property (nonatomic, strong, readonly, nullable) id object;

/**
 Ошибка, возникшая в результате выполнения операции.
 */
@property (nonatomic, strong, readonly, nullable) NSError *error;

@end

NS_ASSUME_NONNULL_END
