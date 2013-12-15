//
//  PolicyDetailViewController.m
//  ShangWuTong_Policy
//
//  Created by Mac OS X on 13-9-28.
//  Copyright (c) 2013年 Eric Inc. All rights reserved.
//

#import "PolicyDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+OnlineImage.h"
#import "OnlineImageView.h"

@interface PolicyDetailViewController ()

@end

@implementation PolicyDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"政策详情";
//        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        // ^-Use UITextAlignmentCenter for older SDKs.
        label.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"政策详情", @"");
        [label sizeToFit];


    }
    return self;
}

//- (void)dealloc
//{
//    [_policyPicArray release];
//    [_policyLableDetail release];
//    [_dictForPolicyData release];
//    [super dealloc];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem.title = @"政策";


//    self.backgroundImageView.frame = CGRectMake(0, 64, 320, 200);
//    self.policyLableDetail.frame = CGRectMake(0,150,320,50);
//    self.policyViewDetail.frame = CGRectMake(60, 0, 200, 140);
    
    self.policyLableType.text = [NSString stringWithFormat:@"%@",[self.dictForPolicyData objectForKey:@"policyName"]];
    self.policyPicArray = [self.dictForPolicyData objectForKey:@"pic"];
    NSLog(@"%@",[self.dictForPolicyData objectForKey:@"policyDesc"]);
    
    //政策详情
    self.policyLableDetail = [[UILabel alloc] init];
    self.policyLableDetail.text = [NSString stringWithFormat:@"%@",[self.dictForPolicyData objectForKey:@"policyDesc"]];
    NSLog(@"%@",self.policyLableDetail.text);
    self.policyLableDetail.lineBreakMode = NSLineBreakByWordWrapping;
    self.policyLableDetail.numberOfLines = 0;
    self.policyLableDetail.backgroundColor = [UIColor lightGrayColor];
    CGSize size = CGSizeMake(320, 2000);
    CGSize labelSize = [self.policyLableDetail.text sizeWithFont:self.policyLableDetail.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.policyLableDetail.frame = CGRectMake(0, 200, labelSize.width, labelSize.height);
    [self.view addSubview:self.policyLableDetail];
    
    //滚动相片
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, 320, 175)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled   = YES;
    scrollView.delegate        = self;
    scrollView.contentSize = CGSizeMake(320*3, 165);
    scrollView.showsHorizontalScrollIndicator = YES;
    //    [c.imgview setImageWithURL:[self.goodsArray[indexPath.row] objectForKey:@"pic"]];

    
    float _x = 0;
    for (int index = 0; index < 3; index++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+_x, 0, 320, 200)];
        
        //去掉注释在每次加载前清空缓存
//        ImageCacheQueue* cache = [ImageCacheQueue sharedCache];
//        [cache clearCache];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
//        imageView.frame = CGRectMake(0+_x, 0, 320, 200);
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+_x, 0, 320, 200)];
      
//        NSString *imageName = [NSString stringWithFormat:@"image%d",index+1];
//        imageView.image = [UIImage imageNamed:imageName];

//        [imageView setImageWithURL:[NSURL URLWithString:[self.policyPicArray objectAtIndex:index]]];

        [imageView setOnlineImage:[self.policyPicArray objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
        
        
        NSLog(@"%@",[self.policyPicArray objectAtIndex:index]);
        
        [scrollView addSubview:imageView];
//        [imageView release];
        _x += 320;
    
    }
    
    [self.view addSubview:scrollView];
//    [scrollView release];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 184-20, 320, 30)];
    
    pageControl.numberOfPages = 3;
    pageControl.tag = 101;
    [self.view addSubview:pageControl];
//    [pageControl release];
    
    self.policyLableDetail.backgroundColor = [UIColor lightGrayColor];
    
//    self.policyViewDetail.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.dictForData objectForKey:@"PolicyView"]]];


//    self.backgroundImageView.backgroundColor = [UIColor lightGrayColor];
//    self.backgroundImageView.alpha = 0;
        
 
//    [self.backgroundImageView addSubview:self.policyViewDetail];
//    [self.backgroundImageView addSubview:self.policyLableDetail];
    
//    [self animateOnEntry];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 250, 80, 60)];
//    btn.titleLabel.text = @"return";
//    btn.backgroundColor = [UIColor cyanColor];
//    [btn addTarget:self action:@selector(PopVC) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

//- (void)animateOnEntry
//{
////    self.backgroundImageView.alpha = 0;
//    self.backgroundImageView.frame = CGRectMake(0, 64, 320, 200);
//    self.policyLableDetail.frame = CGRectMake(0,150,320,50);
//    self.policyViewDetail.frame = CGRectMake(60, 0, 200, 140);
//    [self.view addSubview:self.backgroundImageView];
//    [self.backgroundImageView addSubview:self.policyViewDetail];
//    [self.backgroundImageView addSubview:self.policyLableDetail];
    
    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)PopVC{
//    [self.navigationController popViewControllerAnimated:YES];
//}

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
