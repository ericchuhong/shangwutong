//
//  BaseNavigationViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"Head.png"];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
//        [self.navigationBar setBackgroundColor:[UIColor colorWithRed:7.0/255 green:149.0/255 blue:211.0/255 alpha:0.0]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
