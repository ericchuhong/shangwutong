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
        self.title = @"关于我们";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        // ^-Use UITextAlignmentCenter for older SDKs.
        label.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"关于我们", @"");
        [label sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    // ----- 设置背景图片 -----
//    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollView.showsHorizontalScrollIndicator = NO;

    UIImageView *aboutUS = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutUS.jpg"]];
    aboutUS.frame = CGRectMake(0, 0, 327, 327);
    [scrollView addSubview:aboutUS];
    
    UILabel *intrdc = [[UILabel alloc] initWithFrame:CGRectMake(0, 327, 320, 347)];
    intrdc.numberOfLines = 0;
    intrdc.lineBreakMode = NSLineBreakByWordWrapping;
    intrdc.font = [UIFont systemFontOfSize:14.0];
    intrdc.text = @"关于我们\n\n杭州绿泽网络科技有限公司是一家年轻而充满活力创造新生活方式的公司。为企业移动信息化提供解决方案，为客户提升品牌形象，并降低企业进入移动互联网的门槛，让消费者与品牌之间提升更 好的互动，提高品牌黏度。我们专注无线空间的创造，让移动互联网技术更好的服务于客户，让APP以后更好服务于每个人每个机构。\n\n联系我们\n\n杭州市桐庐县迎春南路227号立山国际1102\n\n主页：http://www.lvzetech.com/\nTel: 0571-29609788\nFax: 0571-29600098\nE-mail: market@lvzetech.com";
    scrollView.contentSize = CGSizeMake(320, 674);
    [scrollView addSubview:intrdc];
    [self.view addSubview:scrollView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
