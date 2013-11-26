//
//  ContactsCell.m
//  PracticeDemo_PhoneCall
//
//  Created by iOS Developer on 13-9-28.
//  Copyright (c) 2013年 iOS Developer. All rights reserved.
//

#import "ContactsCell.h"

#define LABEL_HEIGHT 20
#define LABEL_WIDTH 180

@implementation ContactsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initContactSubviews];
    }
    return self;
}

- (void)initContactSubviews
{
    _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _backgroundImg.backgroundColor = [UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0];
    [self.contentView addSubview:_backgroundImg];
    
    _companyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _companyLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_companyLabel];
    
    _departmentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _departmentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_departmentLabel];
    
    _salerNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _salerNameLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_salerNameLabel];
    
    _telLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _telLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_telLabel];
    
    _phoneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _phoneBtn.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:_phoneBtn];    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundImg.frame = CGRectMake(30, 5, 240, 90);
    
    _companyLabel.frame = CGRectMake(40, 10, LABEL_WIDTH, LABEL_HEIGHT);
    
    _departmentLabel.frame = CGRectMake(_companyLabel.left, _companyLabel.top+20, LABEL_WIDTH, LABEL_HEIGHT);
    
    _salerNameLabel.frame = CGRectMake(_companyLabel.left, _departmentLabel.top+20, LABEL_WIDTH, LABEL_HEIGHT);
    
    _telLabel.frame = CGRectMake(_companyLabel.left, _salerNameLabel.top+20, LABEL_WIDTH, LABEL_HEIGHT);
    
    _phoneBtn.frame = CGRectMake(_companyLabel.right, _companyLabel.top, 80 , 80);
    
    [_phoneBtn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];

}

@end
