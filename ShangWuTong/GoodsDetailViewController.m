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
    self.companyName.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"companyName"]];
    self.companyDesc.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"companyDesc"]];
    self.discountDesc.text = [NSString stringWithFormat:@"%@",[self.dictForDiscData objectForKey:@"discountDesc"]];
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
