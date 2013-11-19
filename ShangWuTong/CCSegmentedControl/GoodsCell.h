//
//  GoodsCell.h
//  PracticeTableViewDemo
//
//  Created by Mac OS X on 13-9-12.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
{


}

//@property (nonatomic, retain) goodsModel *_goods_model;
@property (nonatomic, retain) UIImageView *imgview;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *introduceLabel;
@property (nonatomic, retain) UILabel *discountLabel;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UILabel *starTimeLabel;
@property (nonatomic, retain) UILabel *endTimeLabel;

@end
