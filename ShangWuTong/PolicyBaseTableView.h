//
//  PolicyBaseTableView.h
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-20.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface PolicyBaseTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *policyTableView;
@property (nonatomic, strong) __block ASIHTTPRequest    *policyRequest;
@property (nonatomic, strong) NSMutableDictionary    *policyDict;
@property (nonatomic, strong) NSMutableArray        *policyArray;


- (void)loadDataWithPolicyURL:(NSString *)url;
- (void)reloadDataWithPolicyArray:(NSArray *)array;

@end
