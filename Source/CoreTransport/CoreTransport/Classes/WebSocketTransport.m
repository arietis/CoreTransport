//
//  WebSocketTransport.m
//  CoreTransport
//
//  Created by Egor Taflanidi on 10/20/27 H.
//  Copyright © 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "WebSocketTransport.h"

#import "TransportationError.h"
#import "TransportationParameters.h"
#import "TransportationResult.h"

#import <jetfire/JFRWebSocket.h>

NSTimeInterval const kWebSocketTransportPingIntervalNever = -1.f;

@interface WebSocketTransport ()
@property (nonatomic, readwrite, strong) JFRWebSocket *socket;
@property (nonatomic, readwrite, strong) NSTimer *pingTimer;
@end

@implementation WebSocketTransport

- (instancetype)initWithServiceRoot:(NSString *)serviceRoot
              connectWithParameters:(TransportationParameters *)parameters
                           listener:(id<WebSocketTransportListener>)listener
                       pingInterval:(NSTimeInterval)interval
{
    if (self = [super init]) {
        self.pingTimer = [self firePingTimerWithInterval:interval];
        self.socket = [self socketWithHeaders:parameters.headers
                                atServiceRoot:serviceRoot
                                 withListener:listener];
        [self.socket connect];
    }
    
    return self;
}

+ (instancetype)transportAtServiceRoot:(NSString *)serviceRoot
                 connectWithParameters:(TransportationParameters *)parameters
                              listener:(id<WebSocketTransportListener>)listener
                          pingInverval:(NSTimeInterval)interval
{
    return [[self alloc] initWithServiceRoot:serviceRoot
                       connectWithParameters:parameters
                                    listener:listener
                                pingInterval:interval];
}

- (void)openAtServiceRoot:(NSString *)serviceRoot
    connectWithParameters:(TransportationParameters *)parameters
                 listener:(id<WebSocketTransportListener>)listener
             pingInterval:(NSTimeInterval)interval
{
    if (self.socket && self.socket.isConnected) {
        [self.socket disconnect];
    }
    
    self.socket = [self socketWithHeaders:parameters.headers
                            atServiceRoot:serviceRoot
                             withListener:listener];
    [self.socket connect];
}

- (void)invalidate
{
    [self.pingTimer invalidate];
    [self.socket disconnect];
}

- (BOOL)alive
{
    return self.socket.isConnected;
}

- (BOOL)sendText:(NSString *)text
{
    if (!self.socket.isConnected) {
        return NO;
    }
    
    [self.socket writeString:text];
    return YES;
}

- (BOOL)sendPing
{
    if (!self.socket.isConnected) {
        return NO;
    }
    
    [self.socket writePing:nil];
    return YES;
}

#pragma mark - Частные методы

- (NSTimer *)firePingTimerWithInterval:(NSTimeInterval)interval
{
    if (interval == kWebSocketTransportPingIntervalNever) {
        return nil;
    }
    
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(sendPing)
                                          userInfo:nil
                                           repeats:YES];
}

- (JFRWebSocket *)socketWithHeaders:(NSDictionary *)headers
                      atServiceRoot:(NSString *)root
                       withListener:(id<WebSocketTransportListener>)listener
{
    JFRWebSocket *socket = [self socketWithHeaders:headers
                                     atServiceRoot:root];
    
    typeof(self) __weak weakSelf = self;
    socket.onText = ^(NSString *text) {
        [listener transport:weakSelf didReceiveText:text];
    };
    
    socket.onConnect = ^() {
        [listener transportDidConnect:weakSelf];
    };
    
    socket.onDisconnect = ^(NSError *error) {
        [listener transport:weakSelf didDisconnectWithError:error];
    };
    
    return socket;
}

- (JFRWebSocket *)socketWithHeaders:(NSDictionary *)headers
                      atServiceRoot:(NSString *)root
{
    JFRWebSocket *socket = [self socketAtServiceRoot:root];

    for (NSString *header in headers.allKeys) {
        [socket addHeader:headers[header] forKey:header];
    }
    
    return socket;
}

- (JFRWebSocket *)socketAtServiceRoot:(NSString *)root
{
    return [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:root]
                                   protocols:@[]];
}

@end
