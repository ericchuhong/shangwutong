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

#define SERVER_HOST @"http://122.224.235.74/ecommerce/webService/apiDiscounts?userNick=%@&groupId=1&userKey=%@&type=%@"

@interface DetailViewController ()

//加载详细视图
- (void) loadAllGoodsView;
- (void) loadEatingGoodsView;
- (void) loadLivingGoodsView;
- (void) loadMovingGoodsView;

//- (void) changeBaseView:(UIView *)baseView withSelectedIndex:(NSInteger)selectedIndex;
///////////////////////////////////////////////////////////////////////

//加载数据
//- (void)requestData;

//刷新UI
//- (void)refreshUI;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商务通";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        // ^-Use UITextAlignmentCenter for older SDKs.
        label.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"商务通", @"");
        [label sizeToFit];
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
    [self loadAllGoodsView];
    [self loadMovingGoodsView];
    [self loadEatingGoodsView];
    [self loadLivingGoodsView];
    _allGoodsView.hidden = NO;
    _eatintGoodsView.hidden = YES;
    _movingGoodsView.hidden = YES;
    _livingGoodsView.hidden = YES;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    currentWidth = self.view.frame.size.width;
/*    categorySegment = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,320, 50) withDataSource:self];
//    [self.view addSubview:categorySegment];
//    [categorySegment release];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushView:) name:@"PUSH_GOODS_DETAIL" object:nil];
 */
    self.view.backgroundColor = [UIColor lightGrayColor];
    CCSegmentedControl* segmentedControl = [[CCSegmentedControl alloc] initWithItems:@[@"全部", @"美食", @"住宿", @"娱乐"]];
    segmentedControl.frame = CGRectMake(0, 0, 320, 50);
    
    //设置背景图片，或者设置颜色，或者使用默认白色外观
    segmentedControl.backgroundImage = [UIImage imageNamed:@"segment_bg.png"];
    //segmentedControl.backgroundColor = [UIColor grayColor];
    
    //阴影部分图片，不设置使用默认椭圆外观的stain
    segmentedControl.selectedStainView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stain.png"]];
    segmentedControl.selectedSegmentTextColor = [UIColor whiteColor];
    segmentedControl.segmentTextColor = [self colorWithHexString:@"#535353"];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
}

#pragma mark - CCSegmentedControl private method

- (void)valueChanged:(id)sender
{
    CCSegmentedControl* segmentedControl = sender;
    NSLog(@"%s line:%d segment has changed to %d", __FUNCTION__, __LINE__, segmentedControl.selectedSegmentIndex);
    
    NSInteger Index = segmentedControl.selectedSegmentIndex;
    
    GoodsBaseTableView *allGV = _allGoodsView;
    GoodsBaseTableView *eatGV = _eatintGoodsView;
    GoodsBaseTableView *liveGV = _livingGoodsView;
    GoodsBaseTableView *moveGV = _movingGoodsView;
    
    if (Index == 0) {
        allGV.hidden = NO;
        eatGV.hidden = YES;
        liveGV.hidden = YES;
        moveGV.hidden = YES;
        
        //        [allGV reloadDataWithArray:_allGoodsView.goodsArray];
        
        
    }else if (Index == 1){
        allGV.hidden = YES;
        eatGV.hidden = NO;
        liveGV.hidden = YES;
        moveGV.hidden = YES;
        
        //        [eatGV reloadDataWithArray:_allGoodsView.goodsArray];
        
    }else if (Index == 2){
        allGV.hidden = YES;
        eatGV.hidden = YES;
        liveGV.hidden = NO;
        moveGV.hidden = YES;
        
        //        [eatGV reloadDataWithArray:_livingGoodsView.goodsArray];
        
    }else if (Index == 3){
        
        allGV.hidden = YES;
        eatGV.hidden = YES;
        liveGV.hidden = YES;
        moveGV.hidden = NO;
        
        //        [eatGV reloadDataWithArray:_movingGoodsView.goodsArray];
        
    }
    
}

- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
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
    _allGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth, KDeviceHeight - 20 - 44 - 50 - 49)];
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
    _eatintGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth,KDeviceHeight - 20 - 44 - 50 - 49)];
    _eatintGoodsView.backgroundColor = [UIColor yellowColor];
    
    _eatintGoodsView.tag = kEatingGoodsTag;
    
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"total"];
    
    [_eatintGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_eatintGoodsView];
}

//加载全部住视图
- (void) loadLivingGoodsView
{
    _livingGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth, KDeviceHeight - 20 - 44 - 50 - 49)];
    _livingGoodsView.backgroundColor = [UIColor redColor];
    
    _livingGoodsView.tag = kLivingGoodsTag;
    
//    NSString *userNick = [GoodsModel getUserNick];
//    NSString *userKey = [GoodsModel getUK];
//    
//    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"reside"];
//    
//    [_allGoodsView loadDataWithURL:contactsHost];

    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"total"];
    
    [_livingGoodsView loadDataWithURL:contactsHost];
    
    [self.view addSubview:_livingGoodsView];
}

//加载全部行视图
- (void) loadMovingGoodsView
{
    _movingGoodsView = [[GoodsBaseTableView alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth,KDeviceHeight - 20 - 44 - 50 - 49)];
    _movingGoodsView.backgroundColor = [UIColor cyanColor];
    _movingGoodsView.tag = kMovingGoodsTag;
    _movingGoodsView.goodsArray = _allGoodsView.goodsArray;
    
//    NSString *userNick = [GoodsModel getUserNick];
//    NSString *userKey = [GoodsModel getUK];
//    
//    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"play"];
//    
//    [_allGoodsView loadDataWithURL:contactsHost];
    NSString *userNick = [GoodsModel getUserNick];
    NSString *userKey = [GoodsModel getUK];
    
    NSString *contactsHost = [NSString stringWithFormat:SERVER_HOST,userNick,userKey,@"total"];
    
    [_movingGoodsView loadDataWithURL:contactsHost];
    
    [_movingGoodsView reloadDataWithArray];

    
    [self.view addSubview:_movingGoodsView];
}

//- (void)refreshUI
//{
////    goodsModel *goods_model = _list[0];
//}


/*- (void) changeBaseView:(UIView *)baseView withSelectedIndex:(NSInteger)Index
{
    categorySegment.selectedIndex = Index;
    
    GoodsBaseTableView *allGV = _allGoodsView;
    GoodsBaseTableView *eatGV = _eatintGoodsView;
    GoodsBaseTableView *liveGV = _livingGoodsView;
    GoodsBaseTableView *moveGV = _movingGoodsView;
    
    if (Index == 0) {
        allGV.hidden = NO;
        eatGV.hidden = YES;
        liveGV.hidden = YES;
        moveGV.hidden = YES;
        
//        [allGV reloadDataWithArray:_allGoodsView.goodsArray];

        
    }else if (Index == 1){
        allGV.hidden = YES;
        eatGV.hidden = NO;
        liveGV.hidden = YES;
        moveGV.hidden = YES;
        
//        [eatGV reloadDataWithArray:_allGoodsView.goodsArray];
        
    }else if (Index == 2){
        allGV.hidden = YES;
        eatGV.hidden = YES;
        liveGV.hidden = NO;
        moveGV.hidden = YES;
        
//        [eatGV reloadDataWithArray:_livingGoodsView.goodsArray];
        
    }else if (Index == 3){
        
        allGV.hidden = YES;
        eatGV.hidden = YES;
        liveGV.hidden = YES;
        moveGV.hidden = NO;
        
//        [eatGV reloadDataWithArray:_movingGoodsView.goodsArray];

    }
    
    
}*/


@end
