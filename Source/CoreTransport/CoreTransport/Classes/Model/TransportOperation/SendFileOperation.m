//
//  SendFileOperation.m
//  Pods
//
//  Created by Антон Подеречин on 30.11.15.
//
//

#import "SendFileOperation.h"


@interface SendFileOperation ()
@property (nonatomic, strong, readwrite) NSData *fileData;
@property (nonatomic, strong, readwrite) NSString *fileName;
@property (nonatomic, strong, readwrite) NSString *fileType;
@property (nonatomic, strong, readwrite) NSString *endpoint;
@end


@implementation SendFileOperation

- (instancetype)initWithTransport:(id<Transport>)transport
                       parameters:(TransportationParameters *)parameters
                         fileData:(NSData *)fileData
                         fileName:(NSString *)fileName
                         fileType:(NSString *)fileType
                         endpoint:(NSString *)endpoint
                       completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithTransport:transport parameters:parameters completion:completionBlock]) {
        self.fileData = fileData;
        self.fileName = fileName;
        self.fileType = fileType;
        self.endpoint = endpoint;
    }
    
    return self;
}

+ (instancetype)operationWithTransport:(id<Transport>)transport
                            parameters:(TransportationParameters *)parameters
                              fileData:(NSData *)fileData
                              fileName:(NSString *)fileName
                              fileType:(NSString *)fileType
                              endpoint:(NSString *)endpoint
                            completion:(TransportOperationCompletion)completionBlock
{
    return [[[self class] alloc] initWithTransport:transport
                                        parameters:parameters
                                          fileData:fileData
                                          fileName:fileName
                                          fileType:fileType
                                          endpoint:endpoint
                                        completion:completionBlock];
}

- (void)main
{
    if (self.cancelled) return;
    
    id result = [self.transport sendFile:self.fileData
                                fileName:self.fileName
                                fileType:self.fileType
                          withParameters:self.parameters
                              atEndpoint:self.endpoint];
    
    if (self.cancelled) return;
    self.transportCompletionBlock(result);}

@end
