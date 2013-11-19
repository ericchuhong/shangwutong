//
//  OnlineImageView.m
//  OnlineImageViewDemo
//
//  Created by ccnyou on 10/19/13.
//  Copyright (c) 2013 ccnyou. All rights reserved.
//

#import "OnlineImageView.h"

@implementation OnlineImageView

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
        [downloader startWithUrl:url delegate:self];
    }
    return self;
}

- (id)initWhthURL:(NSString *)url placeholderImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
        AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
        [downloader startWithUrl:url delegate:self];
    }
    return self;
}

- (id)initWhthURL:(NSString *)url placeholderView:(UIView *)view
{
    self = [super init];
    if (self) {
        [self addSubview:view];
        self.placeholderView = view;
        
        AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
        [downloader startWithUrl:url delegate:self];
    }
    return self;
}

- (void)setOnlineImage:(NSString *)url
{
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image
{
    self.image = image;
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

- (void)setOnlineImage:(NSString *)url placeholderView:(UIView *)view
{
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
    }
    
    
    [self addSubview:view];
    self.placeholderView = view;
    
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

#pragma mark -
#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
    });
}

@end
