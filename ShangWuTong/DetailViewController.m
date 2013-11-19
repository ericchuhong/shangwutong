//
//  DetailViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-9-1.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "DetailViewController.h"
#import "GoodsCell.h"
#import "GoodsModel.h"
#import "ShangWuTongNetworkService.h"
#import "GoodsDetailViewController.h"

#define kAllGoodsTag 101
#define kEatingGoodsTag 102
#define kLivingGoodsTag 103
#define kMovingGoodsTag 104

#define SERVER_HOST @"http://124.160.73.170/ecommerce/webService/apiDiscounts?userNick=%@&groupId=1&userKey=%@&type=%@"

@interface DetailViewController ()

//加载详细视图
- (void) loadAllGoodsView;
- (void) loadEatingGoodsView;
- (void) loadLivingGoodsView;
- (void) loadMovingGoodsView;

- (void) changeBaseView:(UIView *)baseView withSelectedIndex:(NSInteger)selectedIndex;
///////////////////////////////////////////////////////////////////////

//加载数据
- (void)requestData;

//刷新UI
- (void)refreshUI;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商务通";
//        categoryArray = @[@"全部",@"吃",@"住",@"行"];
    }
    return self;
}

//- (void)dealloc
//{
//    [_allGoodsView release]; _allGoodsView = nil;
//    [_eatintGoodsView release]; _eatintGoodsView = nil;
//    [_livingGoodsView release]; _livingGoodsView = nil;
//    [_movingGoodsView release]; _movingGoodsView = nil;
//    
//    [super dealloc];
//}

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, KDeviceHeight)];
    self.view = view;
//    [view release];
    [self loadMovingGoodsView];
    [self loadEatingGoodsView];
    [self loadLivingGoodsView];
    [self loadAllGoodsView];

        
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    currentWidth = self.view.frame.size.width;

//    categorySegment = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,320, 50) withDataSource:self];
//    [self.view addSubview:categorySegment];
//    [categorySegment release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushView:) name:@"PUSH_GOODS_DETAIL" object:nil];
}

- (void)pushView:(NSNotification *)notification {
    NSMutableDictionary *dict = [notification.object objectForKey:@"goods"];
    GoodsDetailViewController *detailViewController = [[GoodsDetailViewController alloc] initWithNibName:@"PolicyDetailViewController" bundle:nil];
    detailViewController.dictForDiscData = dict;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - Private Method

//加载全部商品视图
- (void) loadAllGoodsView
{
    _allGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 37, kDeviceWidth, KDeviceHeight - 44+ 44 - 49)];
    _allGoodsView.backgroundColor = [UIColor purpleColor];

    //    _allGoodsView.rowHeight = 80;
    
    _allGoodsView.tag = kAllGoodsTag;
    
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];

    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"total"];
    
    [_allGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_allGoodsView];
    
}

//加载全部吃视图
- (void) loadEatingGoodsView
{
    //    testSegment.frame.origin.y+testSegment.frame.size.height
    _eatintGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 37, kDeviceWidth,KDeviceHeight - 20 + 44 - 49)];
    _eatintGoodsView.backgroundColor = [UIColor yellowColor];
    
        _eatintGoodsView.tag = kEatingGoodsTag;
    
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"food"];
    
    [_allGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_eatintGoodsView];
}

//加载全部住视图
- (void) loadLivingGoodsView
{
    _livingGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 37, kDeviceWidth, KDeviceHeight - 20 + 44 - 49)];
    _livingGoodsView.backgroundColor = [UIColor redColor];
    
    _livingGoodsView.tag = kLivingGoodsTag;
    
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"reside"];
    
    [_allGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_livingGoodsView];
}

//加载全部行视图
- (void) loadMovingGoodsView
{
    _movingGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 37, kDeviceWidth,KDeviceHeight - 20 + 44 - 49)];
    _movingGoodsView.backgroundColor = [UIColor cyanColor];
    _movingGoodsView.tag = kMovingGoodsTag;
    
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"play"];
    
    [_allGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_movingGoodsView];
}

//- (void)refreshUI
//{
////    goodsModel *goods_model = _list[0];
//}


//- (void) changeBaseView:(UIView *)baseView withSelectedIndex:(NSInteger)Index
//{
//    categorySegment.selectedIndex = Index;
//    
//    GoodsBaseTableView *allGV = _allGoodsView;
//    GoodsBaseTableView *eatGV = _eatintGoodsView;
//    GoodsBaseTableView *liveGV = _livingGoodsView;
//    GoodsBaseTableView *moveGV = _movingGoodsView;
//    
//    if (Index == 0) {
//        allGV.hidden = NO;
//        eatGV.hidden = YES;
//        liveGV.hidden = YES;
//        moveGV.hidden = YES;
//        
////        [allGV reloadDataWithArray:_allGoodsView.goodsArray];
//
//        
//    }else if (Index == 1){
//        allGV.hidden = YES;
//        eatGV.hidden = NO;
//        liveGV.hidden = YES;
//        moveGV.hidden = YES;
//        
////        [eatGV reloadDataWithArray:_allGoodsView.goodsArray];
//        
//    }else if (Index == 2){
//        allGV.hidden = YES;
//        eatGV.hidden = YES;
//        liveGV.hidden = NO;
//        moveGV.hidden = YES;
//        
////        [eatGV reloadDataWithArray:_livingGoodsView.goodsArray];
//        
//    }else if (Index == 3){
//        
//        allGV.hidden = YES;
//        eatGV.hidden = YES;
//        liveGV.hidden = YES;
//        moveGV.hidden = NO;
//        
////        [eatGV reloadDataWithArray:_movingGoodsView.goodsArray];
//
//    }
//    
//    
//}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
//        cell = [[[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    
    return cell;
}

# pragma mark - TableView Dalegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
