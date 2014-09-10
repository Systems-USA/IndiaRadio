//
//  CitiesTableViewController.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 23/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "CityStationsTableViewController.h"
#import "CityCell.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController

-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"City";
        
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
    [query orderByAscending:@"city"];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"CityCell";
    
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.lblCity.text = [object objectForKey:@"city"];
    
    cell.imgImage.image = [UIImage imageNamed:@"cities.png"];
    cell.imgImage.file = [object objectForKey:@"image"];
    [cell.imgImage loadInBackground];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"citiesSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * selectedRow = [self.tableView indexPathForSelectedRow];
    CityCell * cityCell = (CityCell*)[self.tableView cellForRowAtIndexPath:selectedRow];
    NSString * city = cityCell.lblCity.text;
    
    CityStationsTableViewController * destinationViewController = segue.destinationViewController;
    
    destinationViewController.city = city;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
