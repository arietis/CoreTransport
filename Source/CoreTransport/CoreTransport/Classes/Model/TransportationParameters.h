//
//  TransportationParameters.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Сущность для передачи всех параметров запроса.
 
 Параметры делятся на body-параметры и заголовки.
 
 По умолчанию считается, что body-параметры для GET-запроса сериализуются в query-параметры (URL).
 Предполагается, что query-параметры (URL-параметры) будут использованы исключительно в 
 GET-запросах, остальные виды запросов query-параметры использовать не будут, только body.
 */
@interface TransportationParameters : NSObject <NSCopying, NSCoding, NSSecureCoding>

/**
 Фабричный метод.
    
 @return Возвращает объект-заглушку с пустыми словарями параметров.
 */
+ (instancetype)emptyParameters;

/**
 Builder-метод.
 Добавляет объект в body-параметры по ключу.
 
 @param object - объект, который необходимо добавить в body-параметры;
 @param key    - ключ, по которому объект записывается в body-параметры.
 
 @return Возвращает себя.
 */
- (instancetype)withObject:(id)object forKey:(NSString *)key;

/**
 Builder-метод.
 Добавляет объект в body-параметры по ключу.
 
 @param object - объект, который необходимо добавить в body-параметры;
 @param key    - ключ, по которому объект записывается в body-параметры.
 
 @return Возвращает экземпляр TransportationParameters.
 */
+ (instancetype)withObject:(id)object forKey:(NSString *)key;

/**
 Builder-метод.
 Добавляет объект в заголовки запроса по ключу.
 
 Заголовок запроса переписывается полностью значением value, если такой заголовок уже был ранее
 зарегистрирован.
 
 @param header - заголовок, который необходимо заполнить;
 @param value  - значение, которое необходимо записать в заголовок.
 
 @return Возвращает себя.
 */
- (instancetype)withHeader:(NSString *)header value:(NSString *)value;

/**
 Builder-метод.
 Добавляет объект в заголовки запроса по ключу.
 
 Заголовок запроса переписывается полностью значением value, если такой заголовок уже был ранее
 зарегистрирован.
 
 @param header - заголовок, который необходимо заполнить;
 @param value  - значение, которое необходимо записать в заголовок.
 
 @return Возвращает экземпляр TransportationParameters. 
 */
+ (instancetype)withHeader:(NSString *)header value:(NSString *)value;

/**
 Builder-метод.
 Добавляет (дописывает) Cookie-параметр.
 
 Для этого достаёт из Cookie-строки значение, и дописывает его в формате
 "$old_value $cookie:$value;"
 
 @param cookie - название Cookie-параметра;
 @param value  - значение Cookie-параметра.
 
 @return Возвращает себя.
 */
- (instancetype)withCookie:(NSString *)cookie value:(NSString *)value;

/**
 Builder-метод.
 Добавляет (дописывает) Cookie-параметр.
 
 Для этого достаёт из Cookie-строки значение, и дописывает его в формате
 "$old_value $cookie:$value;"
 
 @param cookie - название Cookie-параметра;
 @param value  - значение Cookie-параметра.
 
 @return Возвращает экземпляр TransportationParameters. 
 */
+ (instancetype)withCookie:(NSString *)cookie value:(NSString *)value;

- (instancetype)withHttpAuth:(NSString *)value;
+ (instancetype)withHttpAuth:(NSString *)value;

/**
 Параметры, который необходимо передать в тело запроса.
 
 Для GET-запросов сериализуются в query-параметры (URL).
 */
@property (nonatomic, copy, readonly) NSDictionary *bodyParameters;

/**
 Заголовки запроса.
 */
@property (nonatomic, copy, readonly) NSDictionary *headers;

@end

NS_ASSUME_NONNULL_END
