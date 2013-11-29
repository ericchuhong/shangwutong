//
//  GoodsDetailViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-23.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "OnlineImageView.h"
#import "UIImageView+OnlineImage.h"


@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)dealloc
//{
//    [_companyName release];
//    [_companyDesc release];
//    [_goodsPicArray release];
//    [_dictForDiscData release];
//    [_discountDesc release];
//    [super dealloc];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //公司名称
    self.companyName.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"companyName"]];
    
    //初始化
    self.companyDesc = [[UILabel alloc] init];
    self.discountDesc = [[UILabel alloc] init];
    self.seprateImg = [[UIImageView alloc] init];
    UIScrollView *descScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 320, KDeviceHeight - 200 - 49 - 42 - 21)];
    descScrollView.backgroundColor = [UIColor lightGrayColor];
    descScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    descScrollView.showsHorizontalScrollIndicator = NO;
//    公司描述
    self.companyDesc.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"companyDesc"]];
    self.companyDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.companyDesc.numberOfLines = 0;
    self.companyDesc.backgroundColor = [UIColor lightGrayColor];
    CGSize size = CGSizeMake(320, 2000);
    CGSize labelSize = [self.companyDesc.text sizeWithFont:self.companyDesc.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.companyDesc.frame = CGRectMake(0, 0, 320, labelSize.height);
    [descScrollView addSubview:self.companyDesc];
    
    
    //分界线
    self.seprateImg.backgroundColor = [UIColor lightGrayColor];
    self.seprateImg.frame = CGRectMake(0, self.companyDesc.bottom, kDeviceWidth, 25);
    UILabel *disc = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    disc.text = @"优惠详情";
    disc.textAlignment = NSTextAlignmentCenter;
    disc.backgroundColor = [UIColor darkGrayColor];
    disc.textColor = [UIColor lightGrayColor];
    [self.seprateImg addSubview:disc];
    [descScrollView addSubview:self.seprateImg];
    
    //折扣描述
    self.discountDesc.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"discountDesc"]];
    self.discountDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.discountDesc.numberOfLines = 0;
    self.discountDesc.backgroundColor = [UIColor lightGrayColor];
    CGSize disSize = CGSizeMake(320, 2000);
    CGSize disLabelSize = [self.discountDesc.text sizeWithFont:self.discountDesc.font constrainedToSize:disSize lineBreakMode:NSLineBreakByWordWrapping];
    self.discountDesc.frame = CGRectMake(0, self.seprateImg.bottom, 320, disLabelSize.height);
    [descScrollView addSubview:self.discountDesc];
    
    descScrollView.contentSize = CGSizeMake(320, self.companyDesc.height + self.seprateImg.height + self.discountDesc.height);
    [self.view addSubview:descScrollView];
    
    self.goodsPicArray = [self.dictForDiscData objectForKey:@"pic"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, 320, 175)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled   = YES;
    scrollView.delegate        = self;
    scrollView.contentSize = CGSizeMake(320*3, 165);
    scrollView.showsHorizontalScrollIndicator = YES;
    float _x = 0;
    for (int index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+_x, 0, 320, 200)];
        //        NSString *imageName = [NSString stringWithFormat:@"image%d",index+1];
        //        imageView.image = [UIImage imageNamed:imageName];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.goodsPicArray objectAtIndex:index]]]];
//        [imageView setOnlineImage:[self.goodsPicArray objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
        [imageView setOnlineImage:[self.goodsPicArray objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
        
        [scrollView addSubview:imageView];
//        [imageView release];
        _x += 320;
        
    }
    
    [self.view addSubview:scrollView];
//    [scrollView release];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 184 - 20, 320, 30)];
    
    pageControl.numberOfPages = 3;
    pageControl.tag = 101;
    [self.view addSubview:pageControl];
//    [pageControl release];-fno-objc-arc
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else {
        
        int current = scrollView.contentOffset.x/320;
        UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:101];
        pageControl.currentPage = current;
    }
}

@end
