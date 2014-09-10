//
//  GenreCell.h
//  RadioIndia
//
//  Created by Pepe Ramirez on 30/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import <Parse/Parse.h>

@interface GenreCell : PFTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblGenre;
@property (weak, nonatomic) IBOutlet PFImageView *imgImage;

@end
