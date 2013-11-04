//
//  ContacetsViewController.h
//  PracticeDemo_PhoneCall
//
//  Created by iOS Developer on 13-9-28.
//  Copyright (c) 2013年 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ContacetsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    BOOL searchBarButtonClick;
}

@property (nonatomic,strong) NSMutableArray *contactsArray;
@property (nonatomic,strong) NSMutableArray *showContacts;
@property (nonatomic,strong) __block ASIHTTPRequest *request;
@property (nonatomic,strong) NSMutableDictionary *contactsDict;
@property (nonatomic,strong) NSMutableDictionary *searchContactsDic;

@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;

- (void)loadContactDatawithURL:(NSString *)url;

@end
