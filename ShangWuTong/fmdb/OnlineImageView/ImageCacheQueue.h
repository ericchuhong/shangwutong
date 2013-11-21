//
//  ImageCacheQueue.h
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-9.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCacheQueue : NSObject


+ (id)sharedCache;

- (UIImage *)tryToHitImageWithKey:(NSString *)key;
- (void)cacheImage:(UIImage *)image withKey:(NSString *)key;
- (void)clearCache;

@end
