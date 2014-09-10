//
//  FavoriteViewController.h
//  RadioIndia
//
//  Created by SystemsUSA on 8/22/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Parse/Parse.h>
#import "StationList.h"
@interface FavoriteViewController : PFQueryTableViewController
@property StationList * stationList;

@property NSMutableArray *arraForStation;

@end
