//
//  WebSocketTransport.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 10/20/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTransport/Transport.h>

@class WebSocketTransport;

extern NSTimeInterval const kWebSocketTransportPingIntervalNever;

/**
 Протокол для сущностей-слушателей сокетного транспорта.
 */
@protocol WebSocketTransportListener <NSObject>
@required
- (void)transportDidConnect:(WebSocketTransport *)transport;
- (void)transport:(WebSocketTransport *)transport didDisconnectWithError:(NSError *)error;
- (void)transport:(WebSocketTransport *)transport didReceiveText:(NSString *)text;
@end

/**
 Сокетный транспорт.
 */
@interface WebSocketTransport : NSObject

/**
 Конструктор.
 
 @param serviceRoot - URL, на который будет нацелен сокет;
 @param parameters  - параметры запроса; используются только заголовки; @see TransportationParameters
 @param listener    - слушатель транспорта; @see WebSocketTransportListener
 @param interval    - интервал отправки ping; для отключения следует использовать 
 kWebSocketTransportPingIntervalNever.
 
 @return Возвращает инициированный объект-наследник WebSocketTransport.
 */
- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
              connectWithParameters:(TransportationParameters *)parameters
                           listener:(id<WebSocketTransportListener>)listener
                       pingInterval:(NSTimeInterval)interval;

/**
 Конструктор.
 
 @param serviceRoot - URL, на который будет нацелен сокет;
 @param parameters  - параметры запроса; используются только заголовки; @see TransportationParameters
 @param listener    - слушатель транспорта; @see WebSocketTransportListener
 @param interval    - интервал отправки ping; для отключения следует использовать
 kWebSocketTransportPingIntervalNever.
 
 @return Возвращает инициированный объект-наследник WebSocketTransport.
 */
+ (instancetype)transportAtServiceRoot:(NSString *)serviceRoot
                 connectWithParameters:(TransportationParameters *)parameters
                              listener:(id<WebSocketTransportListener>)listener
                          pingInverval:(NSTimeInterval)interval;

/**
 Инициировать соединение.
 
 @param serviceRoot - адрес сокета;
 @param parameters  - параметры запроса; используются только заголовки; @see TransportationParameters
 @param listener    - слушатель транспорта; @see WebSocketTransportListener
 @param interval    - интервал отправки ping; для отключения следует использовать
 kWebSocketTransportPingIntervalNever.
 */
- (void)openAtServiceRoot:(NSString *)serviceRoot
    connectWithParameters:(TransportationParameters *)parameters
                 listener:(id<WebSocketTransportListener>)listener
             pingInterval:(NSTimeInterval)interval;

/**
 Закрыть соединение.
 
 После вызова этого метода транспорт больше работать не будет.
 */
- (void)invalidate;

/**
 Метод проверки статуса транспорта.
 
 @return Возвращает YES, если транспорт всё ещё держит соединение и может отправлять данные.
 */
- (BOOL)alive;

/**
 Метод для отправки текста.
 
 @param text - текст, который необходимо отправить через сокет;
 
 @return Возвращает YES, если транспорт всё ещё держит соединение и может отправлять данные.
 */
- (BOOL)sendText:(NSString *)text;

/**
 Метод для отправки ping.
 
 @return Возвращает YES, если транспорт всё ещё держит соединение и может отправлять данные.
 */
- (BOOL)sendPing;

@end
