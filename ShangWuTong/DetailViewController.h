//
//  DetailViewController.h
//  ShangWuTong
//
//  Created by Mac OS X on 13-9-1.
//  Copyright (c) 2013年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BFSegmentControl.h"
#import "GoodsBaseTableView.h"
#import "BaseViewController.h"


@interface DetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
//    NSArray *categoryArray;
    
//    BFSegmentControl *categorySegment;
    
    CGFloat currentWidth;
    GoodsBaseTableView *_allGoodsView;
    GoodsBaseTableView *_eatintGoodsView;
    GoodsBaseTableView *_livingGoodsView;
    GoodsBaseTableView *_movingGoodsView;
    
    NSMutableArray *_list;
}
@end
