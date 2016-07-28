//
//  SecurityPolicy.h
//  CoreTransport
//
//  Created by Egor Taflanidi on 19/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Политика безопасности, включающая SSL pinning.
 
 Используется вместе с библиотекой AFNetworking. При инстанциировании необходимо предоставить
 «отпечаток пальца» сертификата.
 
 «Отпечаток пальца» сертификата -- это SHA1-хэш полного сертификата в DER-форме.
 Для конвертации PEM-сертификата в DER-форму следует использовать openssl:
 
 <code>
 openssl x509 -in cert.crt -outform DER -out cert.cer
 </code>
 
 Далее, хэш можно вычислить так:
 
 <code>
 sha1sum cert.cer
 </code>
 
 @see http://security.stackexchange.com/a/14345
 */
@interface SecurityPolicy : AFSecurityPolicy

- (instancetype)init NS_UNAVAILABLE;

/**
 Инициализатор.
 
 @param fingerprint - «отпечаток пальца» сертификата.
 
 «Отпечаток пальца» сертификата -- это SHA1-хэш полного сертификата в DER-форме.
 Для конвертации PEM-сертификата в DER-форму следует использовать openssl:
 
 <code>
 openssl x509 -in cert.crt -outform DER -out cert.cer
 </code>
 
 Далее, хэш можно вычислить так:
 
 <code>
 sha1sum cert.cer
 </code>
 
 @see http://security.stackexchange.com/a/14345
 
 @return Возвращает инициированный объект SecurityPolicy.
 */
- (instancetype)initWithCertificateFingerprint:(NSString *)fingerprint NS_DESIGNATED_INITIALIZER;

/**
 Фабричный метод.
 
 @param fingerprint - «отпечаток пальца» сертификата.
 
 «Отпечаток пальца» сертификата -- это SHA1-хэш полного сертификата в DER-форме.
 Для конвертации PEM-сертификата в DER-форму следует использовать openssl:
 
 <code>
 openssl x509 -in cert.crt -outform DER -out cert.cer
 </code>
 
 Далее, хэш можно вычислить так:
 
 <code>
 sha1sum cert.cer
 </code>
 
 @see http://security.stackexchange.com/a/14345
 
 @return Возвращает инициированный объект SecurityPolicy.
 */
+ (instancetype)policyWithCertificateFingerprint:(NSString *)fingerprint;

@end

NS_ASSUME_NONNULL_END
