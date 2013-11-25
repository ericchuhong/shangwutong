//
//  ContactViewController.m
//  ContactViewController
//
//  Created by junqi zhang on 13-10-7.
//  Copyright (c) 2013年 scau. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactsModel.h"
#import "ContacetsViewController.h"
#import "ContacetsViewController.h"

#define GROUP_HOST @"http://124.160.73.170/ecommerce/webService/apiGroupNumLogin?groupId=1&phone=%@&password=%@"

@implementation ContactViewController
@synthesize NumberTextField;
@synthesize PassWordTextField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.NumberTextField.delegate = self;
    self.PassWordTextField.delegate = self;
    
    [self.passwdSwitch addTarget:self action:@selector(passwdSwitchPressed) forControlEvents:UIControlEventValueChanged];
    BOOL switchStatus = [ContactsModel isSavePassword];
    [self.passwdSwitch setOn:switchStatus];
    self.PassWordTextField.text = (switchStatus ? [ContactsModel getPhonePassword] : @"");
}

- (void)viewDidUnload
{
    [self setNumberTextField:nil];
    [self setPassWordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)LoginButtonPressed:(id)sender 
{
    //NSLog(@"%@,%@",[NumberTextField text],[PassWordTextField text]);
    if([[NumberTextField text] isEqualToString:@""])
    {
        //NSLog(@"Number is empty");
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"温馨提示";
        alert.message = @"请填写号码";
        [alert addButtonWithTitle:@"确定"];
        
        [alert show];
        
    }else if([[PassWordTextField text] isEqualToString:@""])
    {
        //NSLog(@"PassWord is empty");
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"温馨提示";
        alert.message = @"请填写密码";
        [alert addButtonWithTitle:@"确定"];
        
        [alert show];
    }else 
    {
//        UIAlertView *alert = [[UIAlertView alloc] init];
//        alert.title = @"温馨提示";
//        alert.message = [NSString stringWithFormat:@"Num:%@\nPassword:%@",[NumberTextField text],[PassWordTextField text]];
//        [alert addButtonWithTitle:@"确定"];
//        [alert show];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self goodsLoginWithPhone:[self.NumberTextField text] phonePassword:[self.PassWordTextField text]];
        });
        
        
    }
}

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender
{
    [NumberTextField resignFirstResponder];
    [PassWordTextField resignFirstResponder];
    
}

- (void)goodsLoginWithPhone:(NSString *)phone
                      phonePassword:(NSString *)phonePassword
{
    //修改出现的错误capturing self strongly in this block is likely to lead to a retain cycle
    __weak typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:GROUP_HOST,phone,phonePassword];
    self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [weakSelf.request setCompletionBlock:^{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        dic = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [NSString stringWithString:[[dic objectForKey:@"flag"]stringValue]];
        if ([result isEqualToString:@"-1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-3"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-2"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else {
            NSLog(@"Login result is:%@",result);
            [ContactsModel setPhone:self.NumberTextField.text andPhonePassword:self.PassWordTextField.text];
//            [ContactsModel setUK:[[dic objectForKey:@"user"] objectForKey:@"userKey"]];
            [ContactsModel setGNK:[[dic objectForKey:@"groupNum"] objectForKey:@"groupNumKey"]];
            ContacetsViewController *contactVC = [[ContacetsViewController alloc] init];
            
            
            
            [self.navigationController pushViewController:contactVC animated:YES];
//            [contactVC release];-fno-objc-arc
        }
        
        
    }];
    [weakSelf.request setFailedBlock:^{
        NSLog(@"Failed %d",[self.request responseStatusCode]);
    }];
    [self.request startAsynchronous];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [NumberTextField resignFirstResponder];
    [PassWordTextField resignFirstResponder];
    return YES;
}

- (void)passwdSwitchPressed
{
    [ContactsModel SavePassword:self.passwdSwitch.on];

}

@end
