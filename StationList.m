//
//  StationList.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 22/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "StationList.h"
#import "PlayerViewController.h"



@implementation StationList


NSMutableArray *arrayToSaveFavorites;

-(id)init
{
    self = [super init];
    if(self)
    {
        // Register observer to be notified when download of data is complete
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(pauseCurrentStation)
                                                     name:@"PlayerInstantiated" object:nil];
        self.stations = [[NSMutableArray alloc] init];
        arrayToSaveFavorites=[[NSMutableArray alloc]init];
     
    }
    return self;
}

-(void)playCurrentStation
{
    NSArray *stationCopy;
    
    if (self.stations) {
        stationCopy=[NSArray arrayWithArray:self.stations];
    }
  [self stopAllStations];
    [[stationCopy objectAtIndex:self.selectedStation] playStation];
}

-(void)pauseCurrentStation
{
    [[self.stations objectAtIndex:self.selectedStation] pauseStation];
}


-(void)addStation:(Station*)station
{
    [self.stations addObject:station];
}

-(void)deleteStation:(NSInteger)indexpath{
    

    [self.stations removeObjectAtIndex:indexpath];
    

    
}

-(void)controlVolume:(float *)valueTocontrol{
    
    [[self.stations objectAtIndex:self.selectedStation]  Volume:valueTocontrol];
}

-(void)playNextStation
{
   
    [self pauseCurrentStation];
    self.selectedStation ++;

    NSLog(@"seleccionada %ld", (long)self.selectedStation);
    if(self.selectedStation < 0)
    {
        self.selectedStation = (int)[self.stations count]; //[[NSNumber numberWithDouble:[self.stations count]] intValue];
    }
    else if(self.selectedStation > [self.stations count]-1)
    {
        self.selectedStation = 0;
    }
    
    [self playCurrentStation];
}

-(void)playPreviousStation
{
   
    [self pauseCurrentStation];
    self.selectedStation --;
    
    
     NSLog(@"seleccionada %ld", (long)self.selectedStation);
    if(self.selectedStation < 0)
    {
        self.selectedStation = (int)[self.stations count]-1; //[[NSNumber numberWithDouble:[self.stations count]] intValue];
    }
    else if(self.selectedStation > [self.stations count])
    {
        self.selectedStation = 0;
    }
    
    [self playCurrentStation];
   
}

-(void)stopAllStations
{
    [self.stations enumerateObjectsUsingBlock:^(Station* object, NSUInteger idx, BOOL *stop) {
        [object.player pause];
    }];
}

-(BOOL)isStationCurrentlyPlaying
{
    return [[self.stations objectAtIndex:self.selectedStation] isCurrentlyPlaying];

}

-(void)addFavorites{
    
 //   PFObject *radioIndia = [PFObject objectWithClassName:@"Favorites"];
//    radioIndia[@"name"] = [[self.stations objectAtIndex:self.selectedStation] name ];
//    radioIndia[@"city"] = [[self.stations objectAtIndex:self.selectedStation] city ];
//    radioIndia[@"url"] = [[self.stations objectAtIndex:self.selectedStation] url ];
//    radioIndia[@"genre"] = [[self.stations objectAtIndex:self.selectedStation] genre ];
//   [radioIndia saveInBackground];
    
    NSUserDefaults *savefavoritesArray=[NSUserDefaults standardUserDefaults];
    
    arrayToSaveFavorites = [NSMutableArray arrayWithArray:[savefavoritesArray objectForKey:@"favoriteArray"]];
    
    NSMutableDictionary *diccionaryTosave=[[NSMutableDictionary alloc]init];
    
    [diccionaryTosave setObject:[[self.stations objectAtIndex:self.selectedStation] name ] forKey:@"name"];
     [diccionaryTosave setObject:[[self.stations objectAtIndex:self.selectedStation] city ] forKey:@"city"];
     [diccionaryTosave setObject:[[self.stations objectAtIndex:self.selectedStation] url ] forKey:@"url"];
     [diccionaryTosave setObject:[[self.stations objectAtIndex:self.selectedStation] genre ] forKey:@"genre"];

    
       [arrayToSaveFavorites addObject:diccionaryTosave];
    NSUserDefaults *favoriteArray =[NSUserDefaults standardUserDefaults];
    [favoriteArray setObject:arrayToSaveFavorites forKey:@"favoriteArray"];
   
    [favoriteArray synchronize];
   // NSString *station=[[self.stations objectAtIndex:self.selectedStation] name ] ;
    
    NSString *message=[NSString stringWithFormat:@"%@ station has been added to your favorites ",[[self.stations objectAtIndex:self.selectedStation] name ]];
    
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"Favorites" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
  
}

@end
