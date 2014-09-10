//
//  Station.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 20/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "Station.h"
#import "MBProgressHUD.h"

@implementation Station

-(id)initWithName:(NSString *)name City:(NSString *)city Url:(NSString*)url Genre:(NSString*)genre
{
    self = [super init];
    if (self) {
        self.name = name;
        self.city = city;
        self.url = url;
        self.genre = genre;
        self.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:url]];
    }
    return self;
}

-(void)playStation
{
    [self.player play];
}

-(void)pauseStation
{
    [self.player pause];
}

-(void)Volume:(float *)valueToChange{
    
    [self.player setVolume:*valueToChange];
}

-(BOOL)isCurrentlyPlaying
{
    BOOL playing = NO;
    if ([self.player rate] != 0.0)
    {
        playing = YES;
    }
    return playing;
}

@end
