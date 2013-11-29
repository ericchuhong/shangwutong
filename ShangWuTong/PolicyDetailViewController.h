//
//  PolicyDetailViewController.h
//  ShangWuTong_Policy
//
//  Created by Mac OS X on 13-9-28.
//  Copyright (c) 2013年 Eric Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyDetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)NSMutableArray *policyPicArray;
@property (nonatomic,retain)IBOutlet UILabel *policyLableType;
@property (nonatomic,retain)UILabel *policyLableDetail;
@property (nonatomic,retain)IBOutlet UIImageView *imgView;


@property (retain, nonatomic) NSMutableDictionary *dictForPolicyData;

@end
