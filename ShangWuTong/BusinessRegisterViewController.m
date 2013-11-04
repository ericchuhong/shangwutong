//
//  BusinessRegisterViewController.m
//  BusinessRegisterViewController
//
//  Created by Mac OS X on 13-9-8.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "BusinessRegisterViewController.h"
#import "GoodsModel.h"
#import "DetailViewController.h"

#define REGIST_HOST @"http://172.18.92.135:8080/ecommerce/webService/apiRegister?groupId=1&userNick=%@&password=%@"

@interface BusinessRegisterViewController ()

@end

@implementation BusinessRegisterViewController

- (void)SubmitHandler:(id)sender
{
    if ([[self.CustomerCompany text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入所在单位" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    } else if ([[self.CustomerName text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的姓名" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else if ([[self.CustomerTELNumber text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else if ([[self.CustomerUsername text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的用户名" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else if ([[self.CustomerPassword text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的密码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }else{
        
        NSString *Info = [ NSString stringWithFormat:@"%@,%@,%@,%@,%@", [_CustomerCompany text],[_CustomerName text],[_CustomerTELNumber text],[_CustomerUsername text],[_CustomerPassword text] ];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:Info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        //[self.navigationController popToRootViewControllerAnimated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self goodsRegistWithUserNick:[self.CustomerUsername text] password:[self.CustomerPassword text]];
        });
    }
}

- (void)goodsRegistWithUserNick:(NSString *)userNick
                      password:(NSString *)password
{
    NSString *url = [NSString stringWithFormat:REGIST_HOST,userNick,password];
    self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.request setCompletionBlock:^{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingAllowFragments error:nil];
        NSString *flag = [NSString stringWithString:[dic objectForKey:@"flag"]];
        if ([flag isEqualToString:@"-1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([flag isEqualToString:@"-2"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要参数" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([flag isEqualToString:@"-3"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名已存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else
        {
            NSLog(@"Login result is:%@",flag);
            [GoodsModel setUserNick:self.CustomerUsername.text andPassword:self.CustomerPassword.text];
            [GoodsModel setUK:[[dic objectForKey:@"user"] objectForKey:@"userKey"]];
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
            [detailVC release];
        }
        
    }];
    
    [self.request setFailedBlock:^{
        NSLog(@"Failed %d",[self.request responseStatusCode]);
    }];
    [self.request startAsynchronous];
}

- (IBAction)backgroundTap:(id)sender
{
    [_CustomerCompany resignFirstResponder];
    [_CustomerName resignFirstResponder];
    [_CustomerTELNumber resignFirstResponder];
    [_CustomerUsername resignFirstResponder];
    [_CustomerPassword resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
