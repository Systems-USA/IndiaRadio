//
//  CityStationsTableViewController.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 24/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Parse/Parse.h>

@interface CityStationsTableViewController : PFQueryTableViewController

@property NSString * city;
@property NSMutableArray *arraForStation;

@end
