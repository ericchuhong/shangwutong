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

#define GROUP_HOST @"http://122.224.235.74/ecommerce/webService/apiGroupNumLogin?groupId=1&phone=%@&password=%@"
#define CONTACTS_HOST @"http://122.224.235.74/ecommerce/webService/apiGroupNums?phone=%@&groupId=1&groupNumKey=%@"


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
    self.title = @"企讯通";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"企讯通", @"");
    [label sizeToFit];
    

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
            
            NSString *phone = [ContactsModel getPhone];
            NSString *GNK = [ContactsModel getGNK];
            
            NSString *contactsHost = [NSString stringWithFormat:CONTACTS_HOST,phone,GNK];
            [self checkContactDatawithURL:contactsHost];
            
            
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

- (void)checkContactDatawithURL:(NSString *)url
{
    NSLog(@"start");
    
    __weak typeof(self) weakSelf = self;
    
    self.checkRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //    NSLog(@"%@",url);
    [weakSelf.checkRequest setCompletionBlock:^{
        self.checkDict = [NSJSONSerialization JSONObjectWithData:[self.checkRequest responseData] options:NSJSONReadingMutableContainers error:nil];
        /* NSLog(@"%@",[[self.contactsDict objectForKey:@"discount"][0] objectForKey:@"name"]);
         self.contactsArray = [NSMutableArray arrayWithArray:[self.contactsDict objectForKey:@"discount"]];*/
        NSString *result = [NSString stringWithString:[[self.checkDict objectForKey:@"flag"] stringValue]];
        if ([result isEqualToString:@"-1"]) {
            //   未知错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-7"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"通讯录服务异常，请重新登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-2"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-6"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else {
            ContacetsViewController *contactVC = [[ContacetsViewController alloc] init];

            [self.navigationController pushViewController:contactVC animated:YES];
        }
    }];
    
    [weakSelf.checkRequest setFailedBlock:^{
        NSLog(@"failed %d",[self.request responseStatusCode]);
    }];
    [self.checkRequest startAsynchronous];
    
}

@end
