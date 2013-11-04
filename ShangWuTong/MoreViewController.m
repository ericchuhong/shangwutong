//
//  MoreViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-9-15.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    // ----- 设置背景图片 -----
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.background.frame = CGRectMake(0, frame.size.height - 44 - 222, frame.size.width, 222);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
