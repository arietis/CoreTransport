//
//  CookiePolicy.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 08.12.15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Правила обработки Cookies.
 */
@interface CookiePolicy : NSObject

/**
 Политика реакции на установку Cookies.
 
 По умолчанию NSHTTPCookieAcceptPolicyNever.
 */
@property (nonatomic, readonly, assign) NSHTTPCookieAcceptPolicy acceptPolicy;

/**
 Хранилище для Cookies.
 
 По умолчанию nil.
 */
@property (nullable, nonatomic, readonly, strong) NSHTTPCookieStorage *storage;

/**
 Должны ли подтягиваться Cookie из хранилища при отправке запроса?
 
 По умолчанию NO.
 */
@property (nonatomic, readonly, assign) BOOL shouldSetAutomatically;

/**
 Конструктор.
 
 @param acceptPolicy - политика реакции на установку Cookies;
 @param storage - хранилище Cookies;
 @param shouldSetAutomatically - должны ли Cookie автоматически устанавливаться для запросов?
 
 @return Возвращает инициированный объект-наследник CookiePolicy.
 */
- (instancetype)initWithAcceptPolicy:(NSHTTPCookieAcceptPolicy)acceptPolicy
                             storage:(nullable NSHTTPCookieStorage *)storage
              shouldSetAutomatically:(BOOL)shouldSetAutomatically NS_DESIGNATED_INITIALIZER;

/**
 Конструктор.
 
 @return Возвращает политику обработки Cookies по умолчани.
 */
+ (instancetype)policy;

/**
 Конструктор.
 
 @param acceptPolicy - политика реакции на установку Cookies;
 @param storage - хранилище Cookies;
 @param shouldSetAutomatically - должны ли Cookie автоматически устанавливаться для запросов?
 
 @return Возвращает инициированный объект-наследник CookiePolicy.
 */
+ (instancetype)policyWithAcceptPolicy:(NSHTTPCookieAcceptPolicy)acceptPolicy
                               storage:(nullable NSHTTPCookieStorage *)storage
                shouldSetAutomatically:(BOOL)shouldSetAutomatically;

@end

NS_ASSUME_NONNULL_END
