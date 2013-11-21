//
//  ImageCacheQueue.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-9.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "ImageCacheQueue.h"
#import "NSString+MD5.h"


@interface ImageCacheQueue ()

@property (nonatomic, strong) NSMutableDictionary *memoryCache;
@property (nonatomic, strong) NSString *diskCachePath;
@property (nonatomic, strong) ImageCacheQueue* instance;        //避免被释放掉

@end

static ImageCacheQueue *sharedCacheQueue = nil;

@implementation ImageCacheQueue


- (id)init
{
    self = [super init];
    if (nil != sharedCacheQueue) {
        //
        NSLog(@"%s line:%d nil != sharedCacheQueue", __FUNCTION__, __LINE__);
    } else {
        self.memoryCache = [[NSMutableDictionary alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        self.diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.diskCachePath]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:self.diskCachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }

    }
    return sharedCacheQueue;
}

+ (id)sharedCache
{
    @synchronized (self) {
        if (nil == sharedCacheQueue) {
            sharedCacheQueue = [[ImageCacheQueue alloc] init];
            sharedCacheQueue.instance = sharedCacheQueue;
            //NSLog(@"%s line:%d", __FUNCTION__, __LINE__);
        }
        return sharedCacheQueue;
    }
}

/* Interface for the delegate */
- (UIImage *)tryToHitImageWithKey:(NSString *)key
{
    UIImage *image = nil;
    image = [self performSelector:@selector(getImageFromCacheByKey:) withObject:key];
    return (nil != image) ? image : [self performSelector:@selector(getImageFromDiskByKey:) withObject:key];
}

- (void)cacheImage:(UIImage *)image withKey:(NSString *)key
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", key, @"key", nil];
    [self performSelector:@selector(cacheImageToMemory:) withObject:info];
    [self performSelector:@selector(cacheImageToDisk:) withObject:info];
}

- (void)clearCache
{
    [self performSelector:@selector(clearMemoryCache)];
    [self performSelector:@selector(clearDiskCache)];
}

/* Real Cache Hitting */
- (UIImage *)getImageFromCacheByKey:(NSDictionary *)key
{
    //return [memoryCache objectForKey:key];
    
    if ([_memoryCache objectForKey:key]) {
#if SHOW_CACHE_MSG
        NSLog(@"%@ was hit in memory cache.\n", key);
#endif 
        return [self.memoryCache objectForKey:key];
    }
    
    return nil;
}

- (UIImage *)getImageFromDiskByKey:(NSString *)key
{
    NSString *localPath = [self.diskCachePath stringByAppendingPathComponent:[key MD5]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        return nil;
    }
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:localPath] ;
    //return (nil == image) ? nil : image;
    
    if (nil != image) {
#if SHOW_CACHE_MSG
        NSLog(@"%@ was hit in disk cache.\n", key);
#endif 
        /* Hitting here means missing in memory cache */
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", key, @"key", nil];
        [self performSelector:@selector(cacheImageToMemory:) withObject:info];
        
        return image;
    }
    
    return nil;
}

/* Cache The Miss Image */
- (void)cacheImageToMemory:(NSDictionary *)info
{
    /* What size is suitable for memoryCache ? */
    /* FIFO Schedule or LRU ? */
    [self.memoryCache setObject:[info objectForKey:@"image"] forKey:[info objectForKey:@"key"]];
    
#if SHOW_CACHE_MSG
    NSLog(@"%s line:%d %@ was cached.", __FUNCTION__, __LINE__, [info objectForKey:@"key"]);
#endif
}

- (void)cacheImageToDisk:(NSDictionary *)info
{
    NSString *key = [info objectForKey:@"key"];
    UIImage *image = [info objectForKey:@"image"];
    
    NSString *localPath = [_diskCachePath stringByAppendingPathComponent:[key MD5]];
    NSData *localData = UIImageJPEGRepresentation(image, 1.0f);
    
    if ([localData length] <= 1) {
        return ;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        [[NSFileManager defaultManager] createFileAtPath:localPath contents:localData attributes:nil];
    }
    
#if SHOW_CACHE_MSG
    NSLog(@"%s line:%d %@ was saved to disk %@.\n", __FUNCTION__, __LINE__, key, localPath);
#endif
}

/* Empty The Cache */
- (void)clearMemoryCache
{
    [_memoryCache removeAllObjects];
}

- (void)clearDiskCache
{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:_diskCachePath error:&error];
    [[NSFileManager defaultManager] createDirectoryAtPath:_diskCachePath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
}

@end
