//
//  ContactsCell.h
//  PracticeDemo_PhoneCall
//
//  Created by iOS Developer on 13-9-28.
//  Copyright (c) 2013年 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell

@property (nonatomic,retain)UIImageView *backgroundImg;
@property (nonatomic,retain)UILabel *companyLabel;
@property (nonatomic,retain)UILabel *departmentLabel;
@property (nonatomic,retain)UILabel *salerNameLabel;
@property (nonatomic,retain)UILabel *telLabel;
@property (nonatomic,retain)UIButton *phoneBtn;

@end
