//
//  PolicyBaseTableView.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-20.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "PolicyBaseTableView.h"
#import "PolicyCell.h"
#import "UIImageView+WebCache.h"
#import "PolicyDetailViewController.h"

#define kAllGoodsTag 101
#define kEatingGoodsTag 102
#define kLivingGoodsTag 103
#define kMovingGoodsTag 104

@implementation PolicyBaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.policyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.policyTableView.dataSource = self;
        self.policyTableView.delegate = self;
        [self addSubview:self.policyTableView];
    }
    return self;
}

- (void)reloadDataWithPolicyArray:(NSArray *)array {
    self.policyArray = [NSMutableArray arrayWithArray:array];
    
    NSInteger policyTag = self.tag;
    switch (policyTag) {
        case kAllGoodsTag:
            self.policyArray = [NSMutableArray arrayWithArray:self.policyArray];
            break;
        case kEatingGoodsTag:
            self.policyArray = [NSMutableArray arrayWithArray:self.policyArray];
            break;
        case kLivingGoodsTag:
            self.policyArray = [NSMutableArray arrayWithArray:self.policyArray];
            break;
        case kMovingGoodsTag:
            self.policyArray = [NSMutableArray arrayWithArray:self.policyArray];
            break;
            
            
        default:
            break;
    }
    
    [self.policyTableView reloadData];
}

- (void)loadDataWithPolicyURL:(NSString *)url {
    NSLog(@"start");
    //    [NSUserDefaults standardUserDefaults];
    
    self.policyRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.policyRequest setCompletionBlock:^{
        
        _policyDict = [NSJSONSerialization JSONObjectWithData:[_policyRequest responseData] options:NSJSONReadingMutableContainers error:nil];
        NSString *result = [NSString stringWithString:[[self.policyDict objectForKey:@"flag"]stringValue]];
        if ([result isEqualToString:@"-1"]) {
            //   未知错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-2"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-6"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else {
            
            
            
            self.policyArray = [NSMutableArray arrayWithArray:[self.policyDict objectForKey:@"policy"]];
            
            
            self.policyArray = [NSMutableArray arrayWithArray:self.policyArray];
            
            
            [self.policyTableView reloadData];
        }
    }];
    [self.policyRequest setFailedBlock:^{
        NSLog(@"%s line:%d failed  = %d", __FUNCTION__, __LINE__, [self.policyRequest responseStatusCode]);
    }];
    [self.policyRequest startAsynchronous];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.policyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PolicyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    PolicyCell *c = (PolicyCell *)cell;
    
    if (indexPath.row < [self.policyArray count]) {
    c.policyDes.text = [self.policyArray[indexPath.row] objectForKey:@"policyDesc"];
//    c.introduceLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"conmpanyDesc"];
//    c.discountLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"discountDesc"];
    
    [c.policyView setImageWithURL:[[self.policyArray[indexPath.row] objectForKey:@"pic"] objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
//    [c.policyView  setOnlineImage:[self.policyPicArray objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
    //    self.policyPicArray = [self.dictForPolicyData objectForKey:@"pic"];

    
//    c.locationLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"location"];
//    c.starTimeLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"starTime"];
//    c.endTimeLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"endTime"];
    
    }
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PolicyDetailViewController *detailViewController = [[PolicyDetailViewController alloc] initWithNibName:@"PolicyDetailViewController" bundle:nil];
    detailViewController.dictForPolicyData = self.policyArray[indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    UIViewController *NC = [self viewController];
    NSLog(@"%@",NC);
    NSLog(@"%@",NC.navigationController.class);
    NSLog(@"%s line:%d", __FUNCTION__, __LINE__);
    NSLog(@"%s line:%d %@", __FUNCTION__, __LINE__, NC);

    
    [NC.navigationController pushViewController:detailViewController animated:YES];
    
//    [detailViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
