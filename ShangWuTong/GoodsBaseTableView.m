//
//  GoodsBaseTableView.m
//  PracticeTableViewDemo
//
//  Created by iOS Developer on 13-9-24.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "GoodsBaseTableView.h"
#import "GoodsCell.h"
#import "UIImageView+WebCache.h"
#import "GoodsDetailViewController.h"

#define kAllGoodsTag 101
#define kEatingGoodsTag 102
#define kLivingGoodsTag 103
#define kMovingGoodsTag 104

@implementation GoodsBaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.goodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.goodsTableView.dataSource = self;
        self.goodsTableView.delegate = self;
        [self addSubview:self.goodsTableView];
    }
    return self;
}

- (void)reloadDataWithArray:(NSArray *)array {
    self.goodsArray = [self.goodsArray mutableCopy];
    
    NSInteger goodsTag = self.tag;
    switch (goodsTag) {
        case kAllGoodsTag:
            self.goodsArray = [self.goodsArray mutableCopy];
            break;
        case kEatingGoodsTag:
            self.goodsArray = [self.goodsArray mutableCopy];
            break;
        case kLivingGoodsTag:
            self.goodsArray = [self.goodsArray mutableCopy];
            break;
        case kMovingGoodsTag:
            self.goodsArray = [self.goodsArray mutableCopy];
            break;
            
            
        default:
            break;
    }
    
    [self.goodsTableView reloadData];
}



- (void)loadDataWithURL:(NSString *)url {
    NSLog(@"start");
//    [NSUserDefaults standardUserDefaults];
    
    self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.request setCompletionBlock:^{
        
    self.goodsDict = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingMutableContainers error:nil];
        NSString *result = [NSString stringWithString:[[self.goodsDict objectForKey:@"flag"] stringValue]];
        if ([result isEqualToString:@"-1"]) {
            //   未知错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-5"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在，请重新登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
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
            
        

        self.goodsArray = [NSMutableArray arrayWithArray:[self.goodsDict objectForKey:@"discount"]];
        
        
        self.goodsArray = [self.goodsArray mutableCopy];
        
        
        [self.goodsTableView reloadData];
        }
    }];
    [self.request setFailedBlock:^{
        NSLog(@"failed %d", [self.request responseStatusCode]);
    }];
    [self.request startAsynchronous];
}
/*
//- (void)reloadUserkey:(NSString *)url {
//
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setCompletionBlock:^{
//        NSLog(@"success %@",[request responseStatusMessage]);
//
//    }];
//    [request setFailedBlock:^{
//        NSLog(@"failed %d",[request responseStatusCode]);
//    }];
//    
//    [request startSynchronous];
//}

*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    GoodsCell *c = (GoodsCell *)cell;
    c.titleLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"companyName"];
    c.introduceLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"conmpanyDesc"];
    c.discountLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"discountDesc"];
    [c.imgview setImageWithURL:[self.goodsArray[indexPath.row] objectForKey:@"pic"]];
    c.locationLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"location"];
    c.starTimeLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"starTime"];
    c.endTimeLabel.text = [self.goodsArray[indexPath.row] objectForKey:@"endTime"];



    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    GoodsDetailViewController *detailViewController = [[GoodsDetailViewController alloc] initWithNibName:@"PolicyDetailViewController" bundle:nil];
//    detailViewController.dictForDiscData = self.goodsArray[indexPath.row];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.goodsArray[indexPath.row], @"goods", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSH_GOODS_DETAIL" object:dict];
    
    // ...
    // Pass the selected object to the new view controller.
//    UIViewController *NC = [self viewController];
//    
//    NSLog(@"%@", NC.navigationController);
//    [NC.navigationController pushViewController:detailViewController animated:YES];
//    [detailViewController release];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
