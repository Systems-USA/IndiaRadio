//
//  Station.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 20/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Station : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * city;
@property (nonatomic,strong) NSString * genre;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) NSNumber *volume;

-(id)initWithName:(NSString *)name City:(NSString *)city Url:(NSString*)url Genre:(NSString*)genre;
-(void)playStation;
-(void)pauseStation;
-(BOOL)isCurrentlyPlaying;
-(void)Volume:(float *)valueToChange;

@end
