//
//  StationList.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 22/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"


@interface StationList : NSObject

@property (nonatomic,strong) NSArray * arraystation;
@property (strong,nonatomic) NSMutableArray * stations;
@property NSInteger selectedStation;




-(id)init;
-(void)playCurrentStation;
-(void)addFavorites;
-(void)pauseCurrentStation;
-(void)addStation:(Station*)station;
-(void)playNextStation;
-(void)playPreviousStation;
-(void)stopAllStations;
-(BOOL)isStationCurrentlyPlaying;
-(void)deleteStation:(NSInteger)indexpath;

-(void)controlVolume:(float *)valueTocontrol;

@end
