//
//  GenreStationsTableViewController.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 30/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Parse/Parse.h>

@interface GenreStationsTableViewController : PFQueryTableViewController

@property NSString * genre;
@property NSMutableArray *arraForStation;


@end
