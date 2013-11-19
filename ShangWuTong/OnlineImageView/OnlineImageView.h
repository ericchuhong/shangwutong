//
//  OnlineImageView.h
//  OnlineImageViewDemo
//
//  Created by ccnyou on 10/19/13.
//  Copyright (c) 2013 ccnyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageDownloader.h"

@interface OnlineImageView : UIImageView <AsyncImageDownloaderDelegate>

- (id)initWithURL:(NSString *)url;
- (id)initWhthURL:(NSString *)url placeholderImage:(UIImage *)image;
- (id)initWhthURL:(NSString *)url placeholderView:(UIView *)view;

- (void)setOnlineImage:(NSString *)url;
- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image;
- (void)setOnlineImage:(NSString *)url placeholderView:(UIView *)view;

@property (nonatomic, strong) UIView* placeholderView;

@end
