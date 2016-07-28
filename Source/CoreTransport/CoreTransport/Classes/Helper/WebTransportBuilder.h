//
//  WebTransportBuilder.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 11.01.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFSecurityPolicy;
@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;
@class CookiePolicy;
@class WebTransport;
@protocol AFURLRequestSerialization;
@protocol AFURLResponseSerialization;

@protocol WebTransportBuilder <NSObject>
@required

/**
 Задать транспорту политику безопасности.
 
 @param policy - политика безопасноти. @see AFSecurityPolicy.
 
 @return Возвращает builder.
 */
- (instancetype)withSecurityPolicy:(AFSecurityPolicy *)policy;

/**
 Задать транспорту сериализатор параметров запросов.
 
 @param requestSerializer - сериализатор параметров запросов; @see AFHTTPRequestSerializer
 
 @return Возвращает builder.
 */
- (instancetype)withRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

/**
 Задать транспорту парсер ответов сервера.
 
 @param responseSerializer - парсер ответов сервера; @see AFHTTPResponseSerializer
 
 @return Возвращает builder.
 */
- (instancetype)withResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;

/**
 Задать транспорту политику обработки cookies.
 
 @param cookiePolicy - политика обработки cookies.
 
 @return Возвращает builder.
 */
- (instancetype)withCookiePolicy:(CookiePolicy *)policy;

/**
 Задать транспорту параметры сессии.
 
 @param sessionConfiguration - настройки сессии; @see NSURLSessionConfiguration
 
 @return Возвращает builder.
 */
- (instancetype)withSessionConfiguration:(NSURLSessionConfiguration *)configuration;

/**
 Сгенерировать транспорт.
 
 @return Возвращает инициированный объект-транспорт с предустановленными параметрами.
 */
- (WebTransport *)create;

@end

/**
 Сущность-builder для создания объектов класса WebTransport.
 */
@interface WebTransportBuilder : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 Инциализатор.
 Инициирует builder root-адресом веб-сервиса, на который будут отправляться запросы транспорта.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 
 По умолчанию задаётся политика безопасности [AFSecurityPolicy defaultPolicy].
 Предполагается использование JSON-формата для сериализации body запросов и ответов сервиса.
 Политика обработки Cookies -- по умолчанию ничего не принимать, нигде не сохранять и не подставлять
 ни в какие запросы автоматически.
 
 @return Возвращает инициированный builder.
 */
- (id <WebTransportBuilder>)initWithServiceRoot:(NSString *)serviceRoot NS_DESIGNATED_INITIALIZER;

/**
 Инциализатор.
 Инициирует builder root-адресом веб-сервиса, на который будут отправляться запросы транспорта.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 
 По умолчанию задаётся политика безопасности [AFSecurityPolicy defaultPolicy].
 Предполагается использование JSON-формата для сериализации body запросов и ответов сервиса.
 Политика обработки Cookies -- по умолчанию ничего не принимать, нигде не сохранять и не подставлять
 ни в какие запросы автоматически.
 
 @return Возвращает инициированный builder.
 */
+ (id <WebTransportBuilder>)builderForServiceRoot:(NSString *)serviceRoot;

@end
