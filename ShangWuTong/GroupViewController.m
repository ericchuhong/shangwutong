//
//  GroupViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "GroupViewController.h"
#import "BussinessLoginViewController.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"集团号码";


        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
            self.navigationItem.title = @"集团号码";
    
    BussinessLoginViewController *loginVC = [[BussinessLoginViewController alloc] init];
    [self presentViewController:loginVC animated:NO completion:nil];
    [self removeFromParentViewController];
    
    [loginVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
