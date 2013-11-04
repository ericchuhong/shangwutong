//
//  BussinessLoginViewController.h
//  BussinessLoginViewController
//
//  Created by junqi zhang on 13-9-8.
//  Copyright (c) 2013年 scau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@interface BussinessLoginViewController : UIViewController
@property (nonatomic, strong) NSString *userKey;
@property (strong, nonatomic) IBOutlet UITextField *NumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *PassWordTextField;
@property (strong, nonatomic) IBOutlet UISwitch       *passwdSwitch;
@property (nonatomic, strong) __block ASIHTTPRequest    *request;

- (IBAction)LoginButtonPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@end
