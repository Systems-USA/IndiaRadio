//
//  FavoriteTableViewController.h
//  RadioIndia
//
//  Created by SystemsUSA on 9/2/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationList.h"

@interface FavoriteTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stationLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property NSMutableArray *arraForStation;
@property StationList * stationList;

@end
