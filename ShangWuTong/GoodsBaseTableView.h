//
//  GoodsBaseTableView.h
//  PracticeTableViewDemo
//
//  Created by iOS Developer on 13-9-24.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface GoodsBaseTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *goodsTableView;
@property (nonatomic, strong) __block ASIHTTPRequest    *request;
@property (nonatomic, strong) NSMutableDictionary    *goodsDict;
@property (nonatomic, strong) NSMutableArray        *goodsArray;
@property (nonatomic, strong) NSMutableArray        *showArray;

- (void)loadDataWithURL:(NSString *)url;
- (void)reloadDataWithArray;


@end
