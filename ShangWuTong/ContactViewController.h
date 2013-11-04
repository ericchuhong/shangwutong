//
//  ContactViewController.h
//  ContactViewController
//
//  Created by junqi zhang on 13-10-7.
//  Copyright (c) 2013年 scau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ContactViewController : UIViewController

@property (nonatomic, strong) NSString *groupNumKey;
@property (nonatomic, strong) __block ASIHTTPRequest    *request;

@property (strong, nonatomic) IBOutlet UITextField *NumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *PassWordTextField;
@property (strong, nonatomic) IBOutlet UISwitch       *passwdSwitch;
- (IBAction)LoginButtonPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@end
