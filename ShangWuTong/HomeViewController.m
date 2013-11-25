//
//  HomeViewController.m
//  ShangWuTong
//
//  Created by Mac OS X on 13-8-28.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "BusinessRegisterViewController.h"
#import "BussinessLoginViewController.h"
#import "UIImageView+WebCache.h"

#define GROUP_HOST @"http://172.18.92.135:8080/ecommerce/webService/apiGetGroup?groupId=1"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"商务通";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
/*    [self loadDataWithURL:GROUP_HOST];
//    
////背景
//    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 200)];
//    bgView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:bgView];
//    
////商城名字
//    UILabel *groupName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//    groupName.backgroundColor = [UIColor greenColor];
//    groupName.text = [self.groupDict objectForKey:@"groupName"];
//    [bgView addSubview:groupName];
//
////商城介绍
//    UILabel *groupDes = [[UILabel alloc] initWithFrame:CGRectMake(0, 165, 320, 40)];
//    groupDes.backgroundColor = [UIColor redColor];
//    groupDes.text = [self.groupDict objectForKey:@"groupDes"];
//    [bgView addSubview:groupDes];
//    
////商城图片
//    UIImageView *groupImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 40, 120, 125)];
//    groupImg.backgroundColor = [UIColor blueColor];
//    [groupImg setImageWithURL:[self.groupDict objectForKey:@"groupCardPic"]];
//    [bgView addSubview:groupImg];
//    
////登陆注册按钮
//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//
//    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
//    [loginButton setFrame:CGRectMake(90, 480-49-44-100, 100, 40)];
//    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginButton];
//    
//    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [registButton setTitle:@"注册" forState:UIControlStateNormal];
//    [registButton setFrame:CGRectMake(210, 480-49-44-100, 100, 40)];
//    [registButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registButton];*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*#pragma mark - private method
//- (void)loadDataWithURL:(NSString *)url
//{
//    self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [self.request setCompletionBlock:^{
//        
//        self.groupDict = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingMutableContainers error:nil];
////        NSLog(@"%@", [[self.goodsDict objectForKey:@"discount"][0] objectForKey:@"endTime"]);
//        NSString *result = [NSString stringWithString:[self.groupDict objectForKey:@"flag"]];
//        if ([result isEqualToString:@"-1"]) {
//            //   未知错误
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else if ([result isEqualToString:@"-2"]) {
//            // 用户名不正确
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else if ([result isEqualToString:@"-6"]) {
//            // 用户名不正确
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }else {
//            self.groupDict = [self.groupDict objectForKey:@"group"];
//        }
//        
//    }];
//    [self.request setFailedBlock:^{
//        NSLog(@"failed %d", [self.request responseStatusCode]);
//    }];
//    [self.request startAsynchronous];
//}*/

/*- (void)login{
//    BussinessLoginViewController *loginlVC = [[BussinessLoginViewController alloc] init];
//    [self.navigationController pushViewController:loginlVC animated:YES];
////    [loginlVC release];
//}
//
//- (void)regist{
//    BusinessRegisterViewController *registlVC = [[BusinessRegisterViewController alloc] init];
//    [self.navigationController pushViewController:registlVC animated:YES];
////    [registlVC release];
//    
//}*/

@end
