//
//  FavoriteStation.h
//  RadioIndia
//
//  Created by SystemsUSA on 8/22/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Parse/Parse.h>

@interface FavoriteStation : PFTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;

@end
