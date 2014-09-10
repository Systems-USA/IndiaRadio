




//
//  PlayerViewController.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 20/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "PlayerViewController.h"


@interface PlayerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;


@end

@implementation PlayerViewController
@synthesize buttonVolume,arraystationList,station,stationLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    stationLabel.text=[[self.arrayForFacebook objectAtIndex:self.stationList.selectedStation]name ];

  //  Station *estacion=[[Station alloc]init];
    
   // estacion= [self.arrayForFacebook objectAtIndex:self.stationList.selectedStation];
//    NSLog(@"estacion seleccionada %ld",(long)self.stationList.selectedStation);
  // NSLog(@"arraforstation %@",arraystationList);
  // NSLog(@"estacion %@",[[arraystationList objectAtIndex:1] name]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerInstantiated" object:nil];
    [self ibaPlayTapped:self.btnPlay];
 
}

-(void)viewWillAppear:(BOOL)animated
{
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerInstantiated" object:nil];
   // [self ibaPlayTapped:self.btnPlay];
    [self updateUI];
}

-(void)updateUI
{
    if([self.stationList isStationCurrentlyPlaying])
    {
        self.btnPlay.selected = YES;
    }else
    {
        self.btnPlay.selected = NO;
    }
}

- (IBAction)ibaPlayTapped:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerInstantiated" object:nil];
    
    if(!sender.selected)
    {
       
        [self.stationList playCurrentStation];
        sender.selected = YES;
        
    }
    else
    {
        [self.stationList pauseCurrentStation];
        sender.selected = NO;
    }
    
}

- (IBAction)btnNext:(UIButton *)sender {
    
    [self.stationList playNextStation];
    stationLabel.text=[[self.arrayForFacebook objectAtIndex:self.stationList.selectedStation]name ];

    
}

- (IBAction)btnPrev:(UIButton *)sender {
    [self.stationList playPreviousStation];
    stationLabel.text=[[self.arrayForFacebook objectAtIndex:self.stationList.selectedStation]name ];

}



- (IBAction)sliderValue:(id)sender {
    
    float value=self.slider.value;
    if (value==0) {
       [buttonVolume setBackgroundImage:[UIImage imageNamed:@"muteButton.png"] forState:UIControlStateNormal];
    }
    
    if (value>=0.31 && value<0.69) {
        [buttonVolume setBackgroundImage:[UIImage imageNamed:@"noMuteButton50.png"] forState:UIControlStateNormal];
    }
    
    if (value>0 && value<0.3) {
        [buttonVolume setBackgroundImage:[UIImage imageNamed:@"noMuteButton30.png"] forState:UIControlStateNormal];
    }
    
    if (value>0.7) {
        [buttonVolume setBackgroundImage:[UIImage imageNamed:@"noMuteButton.png"] forState:UIControlStateNormal];
    }
    
    [self.stationList controlVolume:&value];
    
}

- (IBAction)Share:(id)sender {
    
    Station *estacion=[[Station alloc]init];
    estacion= [self.arrayForFacebook objectAtIndex:self.stationList.selectedStation];
    
    NSString *text = [NSString stringWithFormat:@"I'm listening %@ from %@",estacion.name, estacion.city];
    NSURL *url = [NSURL URLWithString:@"http://sysusit.com/"];

    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    
    
    [self presentViewController:controller animated:YES completion:nil];
    
}




- (IBAction)addFavoritesButton:(id)sender {
  //  NSLog(@"numero de estacion %ld",(long)station );
    
    [self.stationList addFavorites];
    
}



@end
