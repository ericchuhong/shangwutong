//
//  ContacetsViewController.m
//  PracticeDemo_PhoneCall
//
//  Created by iOS Developer on 13-9-28.
//  Copyright (c) 2013年 iOS Developer. All rights reserved.
//

#import "ContacetsViewController.h"
#import "ContactsCell.h"
#import "ContactsModel.h"


#define CONTACTS_HOST @"http://124.160.73.170/ecommerce/webService/apiGroupNums?phone=%@&groupId=1&groupNumKey=%@"
#define CONTACTSSEARCH_HOST @"http://124.160.73.170/ecommerce/webService/apiGroupNumSearch?phone=%@&groupId=1&groupNumKey=%@==&searchText=%@"

@interface ContacetsViewController ()

@end

@implementation ContacetsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSString *phone = [ContactsModel getPhone];
    NSString *GNK = [ContactsModel getGNK];
    
    NSString *contactsHost = [NSString stringWithFormat:CONTACTS_HOST,phone,GNK];
    [self loadContactDatawithURL:contactsHost];
    self.showContacts = [NSMutableArray arrayWithArray:self.contactsArray];
    
    [self initDataBase];

    
}
#pragma mark - DataBase
- (void) initDataBase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"contacts.db"];
    //创建数据库实例 db  这里说明下:如果路径中不存在"contacts.db"的文件,sqlite会自动创建"contacts.db"
    self.db= [FMDatabase databaseWithPath:dbPath] ;
    if (![self.db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
   //创建表
    NSString* sql =
    @"CREATE TABLE IF NOT EXISTS contacts("
    "company TEXT," //对应 FCircle_name
    "department TEXT," //对应 FCircle_PinYin
    "salerName TEXT," //对应 FCircle_ParentID
    "tel TEXT,"
    ");";
    
    if (![self.db executeUpdate:sql]) {
        NSLog(@"%s line:%d 创建表失败:%@", __FUNCTION__, __LINE__, [self.db lastErrorMessage]);
    }
}



- (FMDatabase *)loadDatabase
{
    //获取当前路径
    NSLock* aLock = [[NSLock alloc] init];
    [aLock lock];
    
    if (self.db == nil) {
        NSURL* appUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString* dbPath = [[appUrl path] stringByAppendingPathComponent:@"contacts.db"];
        NSLog(@"%s line:%d db path = %@", __FUNCTION__, __LINE__, dbPath);
        self.db = [FMDatabase databaseWithPath:dbPath];
        if ([self.db open] == NO) {
            NSLog(@"%s line:%d %@", __FUNCTION__, __LINE__, @"数据库未能创建/打开");
            self.db = nil;
        }
    }
    
    [aLock unlock];
    return self.db;
}

//NSArray* items = [json objectForKey:@"items"];
//for (NSDictionary* itemJson in items) {
//    Circle* circle = [[Circle alloc] init];
//    circle.ID = [itemJson objectForKey:@"FCircle_ID"];
//    circle.cityID = [itemJson objectForKey:@"FC_ID"];
//    circle.name = [itemJson objectForKey:@"FCircle_Name"];
//    circle.parentID = [itemJson objectForKey:@"FCircle_ParentID"];
//    circle.pinYin = [itemJson objectForKey:@"FCircle_PinYin"];
//
//
//    if ([circle.parentID intValue] != 0) {
//        //二级商圈
//        [_subDistricts addObject:circle];
//    } else {
//        //顶级商圈
//        [_parentDistricts addObject:circle];
//    }
//
//    NSString* sql = [[NSString alloc] initWithFormat:@"insert or replace into circles values(%@, %@, '%@', '%@', %@)", circle.ID, circle.cityID, circle.name, circle.pinYin, circle.parentID];
//    //NSLog(@"%s line:%d sql = %@", __FUNCTION__, __LINE__, sql);
//    BOOL retCode = [self.dbConn executeUpdate:sql];
//    if (retCode == NO) {
//        NSLog(@"%s line:%d error, msg = %@", __FUNCTION__, __LINE__, [self.dbConn lastError]);
//    }
//}

- (void)loadContactDatawithURL:(NSString *)url
{
    NSLog(@"start");

   
    self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    NSLog(@"%@",url);
    [self.request setCompletionBlock:^{
        self.contactsDict = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingMutableContainers error:nil];
       /* NSLog(@"%@",[[self.contactsDict objectForKey:@"discount"][0] objectForKey:@"name"]);
        self.contactsArray = [NSMutableArray arrayWithArray:[self.contactsDict objectForKey:@"discount"]];*/
        NSString *result = [NSString stringWithString:[[self.contactsDict objectForKey:@"flag"] stringValue]];
        if ([result isEqualToString:@"-1"]) {
            //   未知错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-7"]) {
            // 用户名不正确
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"通讯录用户名不存在，请重新登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
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
            self.contactsArray = [NSMutableArray arrayWithArray:[self.contactsDict objectForKey:@"groupNum"]];
//            self.showContacts = [self.contactsArray mutableCopy];
            
            for (NSDictionary *item in self.contactsArray) {
                ContactsCell *contact = [[ContactsCell alloc] init];
                contact.companyLabel = [item objectForKey:@"companyName"];
                contact.departmentLabel = [item objectForKey:@"department"];
                contact.salerNameLabel = [item objectForKey:@"name"];
                contact.telLabel = [item objectForKey:@"phone"];
                
                [self.contactsArray addObject:contact];
                
                NSString* sql = [[NSString alloc] initWithFormat:@"insert or replace into circles values('%@', '%@', '%@', '%@')", contact.companyLabel,contact.departmentLabel,contact.salerNameLabel, contact.telLabel];
                BOOL retCode = [self.db executeUpdate:sql];
                if (retCode == NO)
                {
                    NSLog(@"%s line:%d error, msg = %@", __FUNCTION__, __LINE__, [self.db lastError]);
                }
            }
            
            self.showContacts = [[NSMutableArray alloc] initWithArray:self.contactsArray];
        
            [self.tableView reloadData];
        }
    }];
    
    [self.request setFailedBlock:^{
        NSLog(@"failed %d",[self.request responseStatusCode]);
    }];
    [self.request startAsynchronous];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.showContacts count]>0?[self.showContacts count]:0;
    return [self.showContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
//    if (self.showContacts != nil && self.showContacts.count >0){
//    NSLog(@"%@",self.showContacts);
//    NSLog(@"%@",self.contactsArray);

    if (indexPath.row < [self.showContacts count]) {
        
    
        cell.companyLabel.text = [NSString stringWithFormat:@"公司:%@",[self.showContacts[indexPath.row] objectForKey:@"companyName"]];
        cell.companyLabel.textColor = [UIColor blackColor];

        
        cell.telLabel.text = [NSString stringWithFormat:@"电话:%@",[self.showContacts[indexPath.row] objectForKey:@"phone"]];
        cell.telLabel.textColor = [UIColor blackColor];
        
        cell.salerNameLabel.text = [NSString stringWithFormat:@"姓名:%@",[self.showContacts[indexPath.row] objectForKey:@"name"]];
        cell.salerNameLabel.textColor = [UIColor blackColor];
        
        cell.departmentLabel.text = [NSString stringWithFormat:@"部门:%@",[self.showContacts[indexPath.row] objectForKey:@"department"]];
        cell.departmentLabel.textColor = [UIColor blackColor];
        
        [cell.phoneBtn addTarget:self action:@selector(callThePhone: event:) forControlEvents:UIControlEventTouchUpInside];
    }
//    }
    return cell;
}

-(void)callThePhone:(id) sender event:(id)event
{
 
  NSSet *touches = [event allTouches];
  UITouch *touch = [touches anyObject];
  CGPoint currentTouchPosition = [touch locationInView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
  if (indexPath == nil) {
  return;
  }
//  NSInteger  section = [indexPath section];
//  NSUInteger  row = [indexPath row];
  NSString *number = [self.showContacts[indexPath.row] objectForKey:@"phone"];
  
  NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串
  
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008611"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBarButtonClick = YES;
    [searchBar resignFirstResponder];
    NSLog(@"%i",[self.showContacts count]);
    [self contactsSearchWithText:searchBar.text];
    NSLog(@"%s line:%d showContact:%@", __FUNCTION__, __LINE__, self.showContacts);
    [self.tableView reloadData];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    // 改变searchbar取消按钮的文字
    for (UIView *subview in searchBar.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)subview;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    NSLog(@"%s line:%d ", __FUNCTION__, __LINE__);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    

    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    self.showContacts = self.contactsArray;
    [self.tableView reloadData];
}

//保存搜索结果
- (void)contactsSearchWithText:(NSString *)searchText
{
    NSString *phone = [ContactsModel getPhone];
    NSString *GNK = [ContactsModel getGNK];
    
    NSString *url = [NSString stringWithFormat:CONTACTSSEARCH_HOST,phone,GNK,searchText];

    self.researchRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.researchRequest  setCompletionBlock:^{
        self.searchContactsDic = [NSJSONSerialization JSONObjectWithData:[self.request responseData] options:NSJSONReadingMutableContainers error:nil];
        NSString *result = [NSString stringWithString:[self.searchContactsDic objectForKey:@"flag"]];
        if ([result isEqualToString:@"-1"]) {
            //未知错误
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未知错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-7"]) {
            // 通讯录用户名不存在，请重新登陆
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"通讯录用户名不存在，请重新登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-2"]) {
            // 缺少必要信息
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少必要信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else if ([result isEqualToString:@"-6"]) {
            // 不存在
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }else {
            
            // 当搜索过后,清空array里面的内容
            if (searchBarButtonClick == YES) {
                [self.showContacts removeAllObjects];
                searchBarButtonClick = NO;
            }
        
        self.showContacts = [NSMutableArray arrayWithArray:[self.searchContactsDic objectForKey:@"groupNum"]];
            [self.tableView reloadData];}
    }];
    
    [self.researchRequest  setFailedBlock:^{
        NSLog(@"failed %d",[self.request responseStatusCode]);
        NSLog(@"%s line:%d failed:%d", __FUNCTION__, __LINE__, [self.researchRequest responseStatusCode]);
    }];
    [self.researchRequest  startAsynchronous];

    
}

@end
