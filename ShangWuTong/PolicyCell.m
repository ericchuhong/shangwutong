//
//  PolicyCell.m
//  ShangWuTong_Policy
//
//  Created by Mac OS X on 13-9-27.
//  Copyright (c) 2013年 Eric Inc. All rights reserved.
//

#import "PolicyCell.h"

@implementation PolicyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initCellView];
    }
    return self;
}

- (void) initCellView
{
    _policyView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _policyView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_policyView];
    
    _policyDes = [[UILabel alloc] initWithFrame:CGRectZero];
    _policyDes.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_policyDes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _policyView.frame = CGRectMake(10,10,80,80);
     
    _policyDes.frame = CGRectMake(_policyView.right+10, _policyView.top, 180, 80);
}

@end
