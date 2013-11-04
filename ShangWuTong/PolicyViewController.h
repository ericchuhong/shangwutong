//
//  PolicyViewController.h
//  ShangWuTong
//  政策首页控制器

//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BFSegmentControl.h"
#import "PolicyBaseTableView.h"
#import "BaseViewController.h"


@interface PolicyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    PolicyBaseTableView *_policyView;
}

@property (nonatomic, strong) UITableView *policyTableView;
@property (nonatomic, strong) __block ASIHTTPRequest    *policyRequest;
@property (nonatomic, strong) NSMutableDictionary    *policyDict;
@property (nonatomic, strong) NSMutableArray        *policyArray;

- (void)loadPolicyDataWithURL:(NSString *)url;

@end
