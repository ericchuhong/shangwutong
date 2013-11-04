//
//  PolicyViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "PolicyViewController.h"
#import "PolicyCell.h"
#import "PolicyDetailViewController.h"
#import "UIImageView+WebCache.h"

#define kAllGoodsTag 101
#define kEatingGoodsTag 102
#define kLivingGoodsTag 103
#define kMovingGoodsTag 104

#define POLICY_HOST @"http://124.160.73.170/ecommerce/webService/apiPolicys?groupId=1&type=total"


@interface PolicyViewController ()

//加载详细视图
- (void) loadPolicyView;
//- (void) loadEatingPolicyView;
//- (void) loadLivingPolicyView;
//- (void) loadMovingPolicyView;
//
//- (void) changePolicyBaseView:(UIView *)baseView withSelectedIndex:(NSInteger)selectedIndex;

@end

@implementation PolicyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"政策";
//        categoryArray = @[@"全部",@"吃",@"住",@"行"];
        
    }
    return self;
}

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}

- (void)dealloc
{
//    [_allPolicyView release]; _allPolicyView = nil;
//    [_eatintPolicyView release]; _eatintPolicyView = nil;
//    [_livingPolicyView release]; _livingPolicyView = nil;
//    [_movingPolicyView release]; _movingPolicyView = nil;
    [_policyView release]; _policyView = nil;
    
    [super dealloc];
}

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44)];
    self.view = view;
    [view release];
    [self loadPolicyView];
}

//- (void)reloadAction:(id)sender
//{
//    [categorySegment reloadData];
//}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"政策";

//    CGRect frame = [[UIScreen mainScreen] applicationFrame];
//    
//    self.policyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    self.policyTableView.dataSource = self;
//    self.policyTableView.delegate = self;
//    [self.view addSubview:self.policyTableView];
    
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    
//    [self loadPolicyDataWithURL:POLICY_HOST];
    
}

/*- (void)loadPolicyDataWithURL:(NSString *)url {
//    NSLog(@"start");
//    //    [NSUserDefaults standardUserDefaults];
//    
//    self.policyRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [self.policyRequest setCompletionBlock:^{
//        
//        self.policyDict = [NSJSONSerialization JSONObjectWithData:[self.policyRequest responseData] options:NSJSONReadingMutableContainers error:nil];
//        NSString *result = [NSString stringWithString:[self.policyDict objectForKey:@"flag"]];
//        if ([result isEqualToString:@"-1"]) {
//            //   未知错误
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else if ([result isEqualToString:@"-2"]) {
//            // 用户名不正确
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else if ([result isEqualToString:@"-6"]) {
//            // 用户名不正确
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else {
//            
//            
//            
//            self.policyArray = [NSMutableArray arrayWithArray:[self.policyDict objectForKey:@"policy"]];
//            
//            
//            self.policyArray = [NSArray arrayWithArray:self.policyArray];
//            
//            
//            [self.policyTableView reloadData];
//        }
//    }];
//    [self.policyRequest setFailedBlock:^{
//        NSLog(@"failed %d", [self.policyRequest responseStatusCode]);
//    }];
//    [self.policyRequest startAsynchronous];
//}
*/
- (void)loadPolicyView
{
    _policyView = [[PolicyBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 44 - 49)];
    _policyView.backgroundColor = [UIColor purpleColor];
    
    //    _allGoodsView.rowHeight = 80;
    
    NSString *contactsHost = [NSString stringWithFormat:POLICY_HOST];
    
    [_policyView loadDataWithPolicyURL:contactsHost];
    
    [self.view addSubview:_policyView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.policyArray count];
    //    return self.policyArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PolicyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PolicyCell *c = (PolicyCell *)cell;
    c.policyDes.text = [self.policyArray[indexPath.row] objectForKey:@"policyDesc"];

    [c.policyView setImageWithURL:[self.policyArray[indexPath.row] objectForKey:@"pic"]];

    
    
    
    return cell;
}



#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PolicyDetailViewController *detailViewController = [[PolicyDetailViewController alloc] initWithNibName:@"PolicyDetailViewController" bundle:nil];
    detailViewController.dictForPolicyData = self.policyArray[indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (UIViewController*)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController*)nextResponder;
//        }
//    }
//    return nil;
//}

@end
