//
//  GoodsModel.h
//  ShangWuTong
//
//  Created by Mac OS X on 13-9-16.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,retain)NSString *goodsTitle;
@property (nonatomic,retain)NSString *goodsIntroduce;
@property (nonatomic,retain)NSString *goodsDiscount;
@property (nonatomic,retain)NSString *goodsImg;

+ (void)setUserNick:(NSString *)userNick
      andPassword:(NSString *)password;
+ (NSString *)getUserNick;
+ (NSString *)getPassword;
+ (void)setUK:(NSString *)UK;
+ (NSString *)getUK;

+ (void)SavePassword:(BOOL)_isSavePassword;
+ (BOOL)isSavePassword;

@end
