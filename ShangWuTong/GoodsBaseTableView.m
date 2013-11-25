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
#import "OnlineImageView.h"
#import "UIImageView+OnlineImage.h"

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

- (void)reloadDataWithArray{
    [self.showArray removeAllObjects];
    
    NSInteger goodsTag = self.tag;
    switch (goodsTag) {
        case kAllGoodsTag:
            for (NSMutableDictionary *goods in self.goodsArray)
            {
                if ([[goods objectForKey:@"type"] isEqualToString:@"全部"])
                {
                    [self.showArray addObject:goods];
                }
            }
            self.goodsArray = [self.goodsArray mutableCopy];
            self.backgroundColor = [UIColor yellowColor];
            break;
        case kEatingGoodsTag:
            for (NSMutableDictionary *goods in self.goodsArray)
            {
                if ([[goods objectForKey:@"type"] isEqualToString:@"住宿"])
                {
                    [self.showArray addObject:goods];
                }
            }
//            self.goodsArray = [self.goodsArray mutableCopy];
            break;
        case kLivingGoodsTag:
//            self.goodsArray = [self.goodsArray mutableCopy];
            for (NSMutableDictionary *goods in self.goodsArray)
            {
                if ([[goods objectForKey:@"type"] isEqualToString:@"美食"])
                {
                    [self.showArray addObject:goods];
                }
            }
            break;
        case kMovingGoodsTag:
            self.goodsArray = [self.goodsArray mutableCopy];
            for (NSMutableDictionary *goods in self.goodsArray)
            {
                if ([[goods objectForKey:@"type"] isEqualToString:@"娱乐"])
                {
                    [self.showArray addObject:goods];
                }
            }
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
        
        
        self.showArray = [self.goodsArray mutableCopy];
            if (self.tag != kAllGoodsTag) {
                [self reloadDataWithArray];
            }
        
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
    return [self.showArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    if (indexPath.row < [self.showArray count]) {
    cell.titleLabel.text = [self.showArray[indexPath.row] objectForKey:@"companyName"];
    cell.introduceLabel.text = [self.showArray[indexPath.row] objectForKey:@"companyDesc"];
    cell.discountLabel.text = [self.showArray[indexPath.row] objectForKey:@"discountDesc"];
        
//    [cell.imgview setImageWithURL:[self.showArray[indexPath.row] objectForKey:@"pic"]];
    [cell.imgview setImageWithURL:[[self.showArray[indexPath.row] objectForKey:@"pic"] objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"Default_failLoad.jpg"]];
        
    cell.locationLabel.text = [self.showArray[indexPath.row] objectForKey:@"location"];
    cell.starTimeLabel.text = [self.showArray[indexPath.row] objectForKey:@"starTime"];
    cell.endTimeLabel.text = [self.showArray[indexPath.row] objectForKey:@"endTime"];
    }


    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsDetailViewController *detailViewController = [[GoodsDetailViewController alloc] initWithNibName:@"GoodsDetailViewController" bundle:nil];
    detailViewController.dictForDiscData = self.showArray[indexPath.row];
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.showArray[indexPath.row], @"goods", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSH_GOODS_DETAIL" object:dict];
    
    // ...
    // Pass the selected object to the new view controller.
    UIViewController *NC = [self viewController];
//
//    NSLog(@"%@", NC.navigationController);
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
