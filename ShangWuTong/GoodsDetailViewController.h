//
//  GoodsDetailViewController.h
//  ShangWuTong
//
//  Created by Mac OS X on 13-10-23.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)NSMutableArray *goodsPicArray;
@property (nonatomic,retain)IBOutlet UILabel *companyName;
@property (nonatomic,retain)UILabel *companyDesc;
@property (nonatomic,retain)UILabel *discountDesc;
@property (nonatomic,retain)UIImageView *seprateImg;

@property (nonatomic,retain) NSMutableDictionary *dictForDiscData;


@end
