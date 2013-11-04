//
//  HomeViewController.h
//  ShangWuTong
//  首页控制器


//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "BaseViewController.h"
#import "ASIHTTPRequest.h"

@interface HomeViewController : BaseViewController

@property (nonatomic, strong) __block ASIHTTPRequest    *request;
@property (nonatomic, strong) NSMutableDictionary    *groupDict;

@end
