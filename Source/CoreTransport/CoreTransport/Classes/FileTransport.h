// 
// FileTransport.h
// AppCode
// 
// Created by Egor Taflanidi on 10/6/2015 AD.
// Copyright (c) 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTransport/Transport.h>

/**
 Сущность, ответственная за транспортировку данных между приложением и файловой системой.
 */
@interface FileTransport : NSObject <Transport>

NS_ASSUME_NONNULL_BEGIN

- (instancetype)init NS_UNAVAILABLE;

/**
 Конструктор. 
 По умолчанию транспорт будет искать файл в директории ресурсов mainBundle.
 
 @param fileName - имя файла, включенного в проект. Например: "entities.json"
 
 @return Возвращает инициированный транспорт.
 */
- (instancetype)initWithFileName:(NSString *)fileName;

/**
 Конструктор.
 
 @param fileName - имя файла, включенного в проект. Например: "entities.json"
 @param path - путь к файлу, включенному в проект
 
 @return Возвращает инициированный транспорт.
 */
- (instancetype)initWithFileName:(NSString *)fileName
                            path:(NSString *)path NS_DESIGNATED_INITIALIZER;

/**
 Конструктор. По умолчанию транспорт будет искать файл в директории ресурсов mainBundle.
 
 @param fileName - имя файла, включенного в проект. Например: "entities.json"
 
 @return Возвращает инициированный транспорт.
 */
+ (instancetype)transportWithFileName:(NSString *)fileName;

/**
 Конструктор. Транспорт будет искать файл в директории, путь к которой передан в параметрах.
 
 @param fileName - имя файла, включенного в проект. Например: "entities.json"
 @param path - путь к файлу, включенному в проект
 
 @return Возвращает инициированный транспорт.
 */
+ (instancetype)transportWithFileName:(NSString *)fileName
                                 path:(NSString *)path;

/**
 @return Путь к директории документов пользователя.
 */
+ (NSString *)pathToDocuments;

NS_ASSUME_NONNULL_END

@end
