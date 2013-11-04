//
//  ContactsModel.h
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-8.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject

+ (void)setPhone:(NSString *)phone
        andPhonePassword:(NSString *)phonePassword;
+ (NSString *)getPhone;
+ (NSString *)getPhonePassword;
+ (void)setGNK:(NSString *)GNK;
+ (NSString *)getGNK;

+ (void)SavePassword:(BOOL)_isSavePassword;
+ (BOOL)isSavePassword;

@end
