//
//  PlayerViewController.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 20/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationList.h"
#import "station.h"

@interface PlayerViewController : UIViewController

@property (nonatomic,strong) NSMutableArray * arraystationList;
@property  NSInteger  station;
@property (nonatomic,strong) StationList * stationList;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *buttonVolume;
@property NSMutableArray *arrayForFacebook;
@property (weak, nonatomic) IBOutlet UIButton *addFavorites;
@property (weak, nonatomic) IBOutlet UILabel *stationLabel;

- (IBAction)sliderValue:(id)sender;
- (IBAction)Share:(id)sender;
- (IBAction)addFavoritesButton:(id)sender;

@end
