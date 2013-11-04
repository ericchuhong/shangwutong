//
//  ContactsModel.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-8.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel

+ (void)setPhone:(NSString *)phone
        andPhonePassword:(NSString *)phonePassword
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:Phone];
    [def removeObjectForKey:PhonePassword];
    
    [def setObject:phone forKey:Phone];
    [def setObject:phonePassword forKey:PhonePassword];
    [def synchronize];
}

+ (NSString *)getPhone
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:Phone];
}

+ (NSString *)getPhonePassword
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:PhonePassword];
}

+ (void)setGNK:(NSString *)GNK
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:GroupNumKey];
    [def setObject:GNK forKey:GroupNumKey];
    [def synchronize];
}

+ (NSString *)getGNK
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults  ];
    return [def objectForKey:GroupNumKey];
}

+ (void)SavePassword:(BOOL)_isSavePassword{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:Phone_isSavePassword];
    [def setObject:(_isSavePassword ? @"1" : @"0") forKey:Goods_isSavePassword];
    [def synchronize];
}

+ (BOOL)isSavePassword{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *value = [def objectForKey:Phone_isSavePassword];
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
