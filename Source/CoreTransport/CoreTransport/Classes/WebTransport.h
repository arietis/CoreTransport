//
//  WebTransport.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTransport/Transport.h>

@class AFSecurityPolicy;
@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;
@class CookiePolicy;
@protocol AFURLRequestSerialization;
@protocol AFURLResponseSerialization;

NS_ASSUME_NONNULL_BEGIN

/**
 Ключ словаря TransportationResult.object для получения тела ответа.
 
 id body = ((NSDictionary *)result.object)[kTransportationResultKeyBody];
 */
extern NSString * const kTransportationResultKeyBody;

/**
 Ключ словаря TransportationResult.object для получения заголовков ответа.
 
 NSDictionary *headers = ((NSDictionary *)result.object)[kTransportationResultKeyHeaders];
 */
extern NSString * const kTransportationResultKeyHeaders;

/**
 HTTP транспорт.
 */
@interface WebTransport : NSObject <Transport>

- (instancetype)init NS_UNAVAILABLE;

/**
 Инциализатор.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 
 По умолчанию задаётся политика безопасности [AFSecurityPolicy defaultPolicy].
 Предполагается использование JSON-формата для сериализации body запросов и ответов сервиса.
 Политика обработки Cookies -- по умолчанию ничего не принимать, нигде не сохранять и не подставлять
 ни в какие запросы автоматически.
 
 @return Возвращает инициированный объект транспорта.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot;

/**
 Инциализатор.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы, плюс задаёт 
 политику безопасности.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 @param policy - политика безопасноти. @see AFSecurityPolicy.
 
 Предполагается использование JSON-формата для сериализации body запросов и ответов сервиса.
 Политика обработки Cookies -- по умолчанию ничего не принимать, нигде не сохранять и не подставлять
 ни в какие запросы автоматически.
 
 @return Возвращает инициированный объект транспорта.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                     securityPolicy:(AFSecurityPolicy *)policy;

/**
 Инициализатор.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы, плюс задаёт
 политику безопасности и параметры сериализации параметров запросов и десериализации ответов
 сервера.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 @param requestSerializer - сериализатор параметров запросов; @see AFHTTPRequestSerializer
 @param responseSerializer - парсер ответов сервера; @see AFHTTPResponseSerializer
 @param securityPolicy - политика безопасности.
 
 Политика обработки Cookies -- по умолчанию ничего не принимать, нигде не сохранять и не подставлять
 ни в какие запросы автоматически.
 
 @return Возвращает инициированный объект транспорта.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy;

/**
 Инициализатор.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы, плюс задаёт 
 политику безопасности и параметры сериализации параметров запросов и десериализации ответов 
 сервера.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 @param requestSerializer - сериализатор параметров запросов; @see AFHTTPRequestSerializer
 @param responseSerializer - парсер ответов сервера; @see AFHTTPResponseSerializer
 @param securityPolicy - политика безопасности.
 @param cookiePolicy - политика обработки cookies.
 
 @return Возвращает инициированный объект транспорта.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy
                       cookiePolicy:(CookiePolicy *)cookiePolicy;

/**
 Инициализатор.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы, плюс задаёт 
 политику безопасности, параметры сериализации параметров запросов и десериализации ответов
 сервера и параметры сессии.
 
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 @param sessionConfiguration - настройки сессии; @see NSURLSessionConfiguration
 @param requestSerializer - сериализатор параметров запросов; @see AFHTTPRequestSerializer
 @param responseSerializer - парсер ответов сервера; @see AFHTTPResponseSerializer
 @param securityPolicy - политика безопасности.
 
 @return Возвращает инициированный объект транспорта.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
               sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration
                  requestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
                 responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                     securityPolicy:(AFSecurityPolicy *)securityPolicy NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 Инициирует транспорт root-адресом веб-сервиса, на который будут отправляться запросы.
    
 @param serviceRoot - полный адрес веб-сервиса. Пример: <code>http://api.customer.com/v1/entities</code>
 
 @return [[[self class] alloc] initWithServiceRoot:serviceRoot];
 */
+ (instancetype)transportWithServiceRoot:(NSString *)serviceRoot;

@end

NS_ASSUME_NONNULL_END
