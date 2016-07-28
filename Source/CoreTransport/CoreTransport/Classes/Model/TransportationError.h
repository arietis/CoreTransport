// 
// TransportationError.h
// AppCode
// 
// Created by Egor Taflanidi on 10/6/2015 AD.
// Copyright (c) 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Домен ошибок транспорта.
 */
extern NSString * const kCoreTransportDomain;

/**
 Ошибка 501: метод не реализован.
 */
extern NSInteger const kCoreTransportErrorOperationNotSupported;

/**
 Ошибки транспортного уровня.
 */
@interface TransportationError : NSError

/**
 Конструктор.
 
 Возвращает ошибку «операция не реализована».
 Подобного рода ошибки предусмотрены для большинства методов транспорта для файловой системы: 
 транспорт файловой системы на этапе написания этого комментария не содержал логики получения 
 сущностей по идентификаторам, а также не содержал логики записи данных на файловую систему.
 
 @return Возвращает инициированный объект TransportationError.
 */
+ (instancetype)errorOperationNotSupported;

@end