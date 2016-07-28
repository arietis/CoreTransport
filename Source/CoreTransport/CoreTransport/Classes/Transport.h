//
//  Transport.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TransportationResult;
@class TransportationParameters;

/**
 Протокол, которому следуют сущности типа «транспорт».
 Все операции -- синхронные.
 */
@protocol Transport <NSObject>
@required

NS_ASSUME_NONNULL_BEGIN

/**
 Операция «Создать сущность».
 
 Пример:
 POST http://api.customer.com/v1/entities
 $headers
 { $body_parameters }
 
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters;

/**
 Операция «Создать сущность».

 Пример:
 POST http://api.customer.com/v1/entities/{endpoint}
 $headers
 { $body_parameters }

 @param parameters - параметры запроса. @see TransportationParameters
 @param endpoint - URL-оконечник для создания объекта. По умолчанию create

 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters
                                    atEndpoint:(nullable NSString *)endpoint;

/**
 Операция «Отправить файл».
 
 Пример:
 POST http://api.customer.com/v1/entities/{endpoint}
 $headers
 { $body_parameters }
 
 @param fileData - содержимое файла
 @param fileName - Имя файла. Например: "avatar.jpg"
 @param fileType - mime тип файла. Например: "image/jpeg"
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)sendFile:(NSData *)fileData
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint;

/**
 Операция «Отправить файл» с возможностью установить необходимое
    название парметра отправляемого файла.
 
 Пример:
 POST http://api.customer.com/v1/entities/{endpoint}
 $headers
 { $body_parameters }
 
 @param fileData - содержимое файла
 @param partName - значение переменой name. Например: name="file"
 @param fileName - Имя файла. Например: "avatar.jpg"
 @param fileType - mime тип файла. Например: "image/jpeg"
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)sendFile:(NSData *)fileData
                        asBodyPart:(NSString *)partName
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint;

/**
 Операция «Получить коллекцию сущностей».
 
 Пример:
 GET http://api.customer.com/v1/entitites
 $headers
 
 @param parameters - параметры запроса. @see TransportationParameters
    
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)obtainAllWithParameters:(TransportationParameters *)parameters;

/**
 Операция «Получить сущность по идентификатору».
 
 Пример:
 GET http://api.customer.com/v1/entitites/{entityId}
 $headers
 
 @param entityId   - идентификатор сущности;
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)obtainWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters;

/**
 Операция «Получить значение свойства сущности».
 
 Пример:
 GET http://api.customer.com/v1/entitites/{entityId}/{property}
 $headers
 
 @param entityId   - идентификатор сущности;
 @param property   - название свойства сущности;
 @param parameters - параметры запроса. @see TransportationParameters

 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)obtainWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters;

/**
 Операция «Обновить сущность по идентификатору».
 
 Пример:
 PUT http://api.customer.com/v1/entitites/{entityId}
 $headers
 { $body_parameters }
 
 @param entityId   - идентификатор сущности;
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)updateWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters;

/**
 Операция «Исправить сущность по идентификатору».
 
 Пример:
 PATCH http://api.customer.com/v1/entitites/{entityId}
 $headers
 { $body_parameters }
 
 @param entityId   - идентификатор сущности;
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)patchWithId:(NSString *)entityId
                           parameters:(TransportationParameters *)parameters;

/**
 Операция «Обновить значение свойства сущности».
 
 Пример:
 PATCH http://api.customer.com/v1/entitites/{entityId}/{property}
 $headers
 { $body_parameters }
 
 @param entityId   - идентификатор сущности;
 @param property   - название свойства сущности;
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)updateWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters;

/**
 Операция «Удалить сущность по идентификатору».
 
 Пример:
 DELETE http://api.customer.com/v1/entitites/{entityId}
 $headers
 { $body_parameters }
 
 @param entityId   - идентификатор сущности;
 @param parameters - параметры запроса. @see TransportationParameters
 
 @return Возвращает результат выполнения операции.
 */
- (TransportationResult *)deleteWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters;

NS_ASSUME_NONNULL_END

@end
