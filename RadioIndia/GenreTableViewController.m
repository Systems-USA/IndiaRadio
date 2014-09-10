//
//  GenreTableViewController.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 23/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "GenreTableViewController.h"
#import "GenreStationsTableViewController.h"
#import "GenreCell.h"

@interface GenreTableViewController ()

@end

@implementation GenreTableViewController

-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Genre";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    /*[query whereKey:@"ProvZip" containedIn:_userZips];
     [query whereKey:@"Service" containsString:_service];
     [query whereKey:@"Type" containsString:_type];*/
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
    }
    [query orderByAscending:@"genre"];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"GenreCell";
    
    GenreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GenreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.lblGenre.text = [object objectForKey:@"genre"];
    
    cell.imgImage.image = [UIImage imageNamed:@"genre.png"];
    cell.imgImage.file = [object objectForKey:@"image"];
    [cell.imgImage loadInBackground];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"genresSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * selectedRow = [self.tableView indexPathForSelectedRow];
    GenreCell * genreCell = (GenreCell*)[self.tableView cellForRowAtIndexPath:selectedRow];
    NSString * genre = genreCell.lblGenre.text;
    
    GenreStationsTableViewController * destinationViewController = segue.destinationViewController;
    
    destinationViewController.genre = genre;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

