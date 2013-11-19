//
//  GoodsCell.m
//  PracticeTableViewDemo
//
//  Created by Mac OS X on 13-9-12.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "GoodsCell.h"
//#import "UIImageView+WebCache.h"

@implementation GoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [self initSubviews];
    }
    return self;
}

- (void) initSubviews
{
    _imgview = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgview.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imgview];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_titleLabel];
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _introduceLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_introduceLabel];
    
    _discountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _discountLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_discountLabel];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _locationLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_locationLabel];

    _starTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _starTimeLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_starTimeLabel];
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _endTimeLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_endTimeLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    NSDictionary *contentDic = self._goods_model;
    
    _imgview.frame = CGRectMake(10, 10, 80, 80);
//    NSString *imgURL = [[contentDic objectForKey:@"images"] objectForKey:@"medium"];
    
    //异步请求图片
//    [_imgview setImageWithURL:[NSURL URLWithString:imgURL]];
    
    _titleLabel.frame = CGRectMake(_imgview.right+10, 10, 200, 20);
//    _titleLabel.text = [contentDic objectForKey:@"title"];
    
    _introduceLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, 20);
//    _introduceLabel.text = [contentDic objectForKey:@"introduce"];
    
    _discountLabel.frame = CGRectMake(_titleLabel.left,_introduceLabel.bottom , _titleLabel.width, 20);
//    _discountLabel.text = [contentDic objectForKey:@"discount"];
    
    _locationLabel.frame = CGRectMake(_titleLabel.left, _discountLabel.bottom, _titleLabel.width, 20);
    
    _starTimeLabel.frame = CGRectMake(_titleLabel.left, _locationLabel.bottom, _titleLabel.width/2, 20);
    
    _endTimeLabel.frame = CGRectMake(_starTimeLabel.right, _locationLabel.bottom, _titleLabel.width/2, 20);
}

//- (void)dealloc
//{
//
//    [_imgview release];_imgview = nil;
//    [_titleLabel release];_titleLabel = nil;
//    [_introduceLabel release];_introduceLabel = nil;
//    [_discountLabel release];_discountLabel = nil;    
//    [super dealloc];
//}

@end
