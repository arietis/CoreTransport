//
//  SendFileWithPartNameOperation.m
//  CoreTransport
//
//  Created by Andrei Rozhkov on 01/03/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

#import "SendFileWithPartNameOperation.h"


@interface SendFileWithPartNameOperation ()
@property (nonatomic, strong, readwrite) NSData *fileData;
@property (nonatomic, strong, readwrite) NSString *partName;
@property (nonatomic, strong, readwrite) NSString *fileName;
@property (nonatomic, strong, readwrite) NSString *fileType;
@property (nonatomic, strong, readwrite) NSString *endpoint;
@end


@implementation SendFileWithPartNameOperation

- (instancetype)initWithTransport:(id<Transport>)transport
                       parameters:(TransportationParameters *)parameters
                         fileData:(NSData *)fileData
                       asBodyPart:(NSString *)partName
                         fileName:(NSString *)fileName
                         fileType:(NSString *)fileType
                         endpoint:(NSString *)endpoint
                       completion:(TransportOperationCompletion)completionBlock
{
    if (self = [super initWithTransport:transport parameters:parameters completion:completionBlock]) {
        self.fileData = fileData;
        self.partName = partName;
        self.fileName = fileName;
        self.fileType = fileType;
        self.endpoint = endpoint;
    }
    
    return self;
}

+ (instancetype)operationWithTransport:(id<Transport>)transport
                            parameters:(TransportationParameters *)parameters
                              fileData:(NSData *)fileData
                            asBodyPart:(NSString *)partName
                              fileName:(NSString *)fileName
                              fileType:(NSString *)fileType
                              endpoint:(NSString *)endpoint
                            completion:(TransportOperationCompletion)completionBlock
{
    return [[[self class] alloc] initWithTransport:transport
                                        parameters:parameters
                                          fileData:fileData
                                        asBodyPart:partName
                                          fileName:fileName
                                          fileType:fileType
                                          endpoint:endpoint
                                        completion:completionBlock];
}

- (void)main
{
    if (self.cancelled) return;
    
    id result = [self.transport sendFile:self.fileData
                              asBodyPart:self.partName
                                fileName:self.fileName
                                fileType:self.fileType
                          withParameters:self.parameters
                              atEndpoint:self.endpoint];
    
    if (self.cancelled) return;
    self.transportCompletionBlock(result);}

@end
