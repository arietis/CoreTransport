//
//  SendFileOperation.h
//  Pods
//
//  Created by Антон Подеречин on 30.11.15.
//
//

#import <CoreTransport/CoreTransport.h>


/**
 Операция для транспортного метода -sendFile:fileName:fileType:withParameters:atEndpoint:.
 */
@interface SendFileOperation : ParameterizedOperation

/**
 Содержимое файла.
 */
@property (nonatomic, strong, readonly) NSData *fileData;

/**
 Имя файла. Используется для того чтобы получатель знал имя которое ассоциируется с файлом,
 данные с локального диска не запрашиваются.
 */
@property (nonatomic, strong, readonly) NSString *fileName;

/**
 MIME тип файла.
 
 Например: "image/jpeg".
 */
@property (nonatomic, strong, readonly) NSString *fileType;

/**
 Суффикс пути по которому будет отправлен файл.
 */
@property (nonatomic, strong, readonly) NSString *endpoint;


/**
 Инициализатор.
 
 @param transport - транспорт
 @param parameters - параметры запроса
 @param fileData - содержимое файла
 @param fileType - MIME тип файла
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
- (instancetype)initWithTransport:(id<Transport>)transport
                       parameters:(TransportationParameters *)parameters
                         fileData:(NSData *)fileData
                         fileName:(NSString *)fileName
                         fileType:(NSString *)fileType
                         endpoint:(NSString *)endpoint
                       completion:(TransportOperationCompletion)completionBlock;

/**
 Фабричный метод.
 
 @param transport - транспорт
 @param parameters - параметры запроса
 @param fileData - содержимое файла
 @param fileType - MIME тип файла
 @param completionBlock - блок, который необходимо вызвать по завершению операции.
 
 @see TransportOperationCompletion
 
 @return Возвращает инициированный объект операции.
 */
+ (instancetype)operationWithTransport:(id<Transport>)transport
                            parameters:(TransportationParameters *)parameters
                              fileData:(NSData *)fileData
                              fileName:(NSString *)fileName
                              fileType:(NSString *)fileType
                              endpoint:(NSString *)endpoint
                            completion:(TransportOperationCompletion)completionBlock;

@end
