//
//  BusinessRegisterViewController.h
//  BusinessRegisterViewController
//
//  Created by Mac OS X on 13-9-8.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface BusinessRegisterViewController : UIViewController<UIApplicationDelegate,UITextInputTraits,UITextFieldDelegate>

@property (nonatomic, strong) __block ASIHTTPRequest    *request;

@property (nonatomic,assign) IBOutlet UITextField *CustomerCompany;
@property (nonatomic,assign) IBOutlet UITextField *CustomerName;
@property (nonatomic,assign) IBOutlet UITextField *CustomerTELNumber;
@property (nonatomic,assign) IBOutlet UITextField *CustomerUsername;
@property (nonatomic,assign) IBOutlet UITextField *CustomerPassword;
@property (nonatomic,assign) IBOutlet UIButton *Submit;

- (IBAction)SubmitHandler:(id)sender;
-(IBAction)backgroundTap:(id)sender;

@end
