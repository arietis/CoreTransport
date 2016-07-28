// 
// FileTransport.m
// AppCode
// 
// Created by Egor Taflanidi on 10/6/2015 AD.
// Copyright (c) 2015 RedMadRobot LLC. All rights reserved.
//

#import "FileTransport.h"
#import "TransportationResult.h"
#import "TransportationError.h"

@interface FileTransport ()
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *pathToFile;
@end

@implementation FileTransport

- (instancetype)initWithFileName:(NSString *)fileName
{
    return [self initWithFileName:fileName path:[[NSBundle mainBundle] resourcePath]];
}

- (instancetype)initWithFileName:(NSString *)fileName
                            path:(NSString *)path
{
    self = [super init];
    if (self) {
        self.fileName = fileName;
        self.pathToFile = path;
    }

    return self;
}

+ (instancetype)transportWithFileName:(NSString *)fileName
{
    return [[self alloc] initWithFileName:fileName];
}

+ (instancetype)transportWithFileName:(NSString *)fileName
                                 path:(NSString *)path
{
    return [[self alloc] initWithFileName:fileName path:path];
}

+ (NSString *)pathToDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)createWithParameters:(TransportationParameters *)parameters
                                    atEndpoint:(nullable NSString *)endpoint
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)sendFile:(NSData *)fileData
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint
{
    return [self sendFile:fileData
               asBodyPart:@"file"
                 fileName:fileName
                 fileType:fileType
           withParameters:parameters
               atEndpoint:endpoint];
}

- (TransportationResult *)sendFile:(NSData *)fileData
                        asBodyPart:(NSString *)partName
                          fileName:(NSString *)fileName
                          fileType:(NSString *)fileType
                    withParameters:(TransportationParameters *)parameters
                        atEndpoint:(NSString *)endpoint
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)obtainAllWithParameters:(TransportationParameters *)parameters
{
    NSString *pathForJson = [self.pathToFile stringByAppendingPathComponent:self.fileName];

    NSDictionary *responseObject = @{};
    NSError *error = nil;
    if (pathForJson && [pathForJson length]) {
        NSData *fileData = [[NSData alloc] initWithContentsOfFile:pathForJson];
        responseObject   = [NSJSONSerialization JSONObjectWithData:fileData
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    }

    return [TransportationResult resultWithObject:responseObject
                                            error:error];
}

- (TransportationResult *)obtainWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)obtainWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)updateWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)patchWithId:(NSString *)entityId
                           parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)updateWithId:(NSString *)entityId
                              property:(NSString *)property
                            parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)deleteWithId:(NSString *)entityId
                            parameters:(TransportationParameters *)parameters
{
    return [self resultErrorOperationNotSupported];
}

- (TransportationResult *)resultErrorOperationNotSupported
{
    return [TransportationResult resultWithObject:nil
                                            error:[TransportationError errorOperationNotSupported]];
}

@end