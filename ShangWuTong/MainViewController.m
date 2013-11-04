//
//  MainViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "PolicyViewController.h"
#import "ContactViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewController];
    [self _initTabbarview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化子控制器
- (void)_initViewController {
    HomeViewController *home = [[HomeViewController alloc] init];
    PolicyViewController *policy = [[PolicyViewController alloc] initWithNibName:@"PolicyViewController" bundle:nil];
    ContactViewController *group = [[ContactViewController alloc] init];
    MoreViewController *more = [[MoreViewController alloc] init];
    
//    NSArray *views = @[home,policy,group,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    
  /*  for (UIViewController *viewController in views) {
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
        [nav release];
    }
    */
    BaseNavigationViewController *homeNavi = [[BaseNavigationViewController alloc]initWithRootViewController:home];
    [viewControllers addObject:homeNavi];
    
    BaseNavigationViewController *policyNavi = [[BaseNavigationViewController alloc]initWithRootViewController:policy];
    [viewControllers addObject:policyNavi];
    
    BaseNavigationViewController *groupNavi = [[BaseNavigationViewController alloc]initWithRootViewController:group];
    [viewControllers addObject:groupNavi];
    BaseNavigationViewController *moreNavi = [[BaseNavigationViewController alloc]initWithRootViewController:more];
    [viewControllers addObject:moreNavi];
    
    
    
    
    self.viewControllers = viewControllers;
    
}

- (void)_initTabbarview {
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, KDeviceHeight-49, 320, 49)];
//    _tabbarView.BackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBar"]];
    _tabbarView.BackgroundColor = [UIColor colorWithRed:7.0/255 green:149.0/255 blue:211.0/255 alpha:1.0];

    [self.view addSubview:_tabbarView];
    
    //初始化自定义选中背景
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(13.5, 49.0/2-45/2, 53, 45)];
    _selectView.image = [UIImage imageNamed:@"select"];
    [_tabbarView addSubview:_selectView];
    
//    NSArray *background = @[@"TabBar_Home.png",@"TabBar_Policy.png",@"TabBar_Phone.png",@"TabBar_More.png"];
    NSArray *background = @[@"Home",@"Policy",@"Phone",@"More"];
    
    for (int i = 0; i < background.count; i++) {
        NSString *backgroundImage = background[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((80-30)/2.0+80*i, (49-30)/2, 30, 30);
//        btn.frame = CGRectMake((106-32)/2+106*i, (49-30)/2, 30, 30);

        btn.tag = i;
        
        [btn setImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:btn];
        
    }
}

- (void) selectTab:(UIButton *)btn
{
    self.selectedIndex = btn.tag;
    
    [UIView beginAnimations:nil context:NULL];
    _selectView.frame = CGRectMake(13.5+btn.tag*80, 49.0/2-45.0/2, 53, 45);
    [UIView commitAnimations];
}



@end
