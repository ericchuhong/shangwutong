//
//  GoodsModel.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-9-16.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (void)dealloc
{
    self.goodsDiscount = nil;
    self.goodsIntroduce = nil;
    self.goodsTitle = nil;
    self.goodsImg = nil;
    [super dealloc];
}

+ (void)setUserNick:(NSString *)userNick
        andPassword:(NSString *)password
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:UserNick];
    [def removeObjectForKey:Password];
    
    [def setObject:userNick forKey:UserNick];
    [def setObject:password forKey:Password];
    [def synchronize];
}

+ (NSString *)getUserNick
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:UserNick];
}

+ (NSString *)getPassword
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:Password];
}

+ (void)setUK:(NSString *)UK
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:UserKey];
    [def setObject:UK forKey:UserKey];
    [def synchronize];
}

+ (NSString *)getUK
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults  ];
    return [def objectForKey:UserKey];
}

+ (void)SavePassword:(BOOL)_isSavePassword{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:Goods_isSavePassword];
    [def setObject:(_isSavePassword ? @"1" : @"0") forKey:Goods_isSavePassword];
    [def synchronize];
}

+ (BOOL)isSavePassword{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *value = [def objectForKey:Goods_isSavePassword];
    if (value && [value isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
