//
//  StationsTableViewController.m
//  RadioIndia
//
//  Created by Pepe Ramirez on 17/05/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "StationsTableViewController.h"
#import "StationCell.h"
#import "Station.h"
#import "StationList.h"
#import "PlayerViewController.h"

@interface StationsTableViewController ()

@property StationList * stationList;
@property NSMutableArray *arraForStation;
@end

@implementation StationsTableViewController


-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Station";
        
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
    [query orderByDescending:@"name"];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"StationCell";
    
   // NSLog(@"objetos %@",object);
    
    StationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    Station* station = [[Station alloc] initWithName:[object objectForKey:@"name"] City:[object objectForKey:@"city"] Url:[object objectForKey:@"url"] Genre:[object objectForKey:@"genre"]];
    
    // Configure the cell
    cell.lblName.text = station.name;
    [self.arraForStation addObject:station];
    cell.lblCity.text = station.city;
    //cell.imgImage.image = [UIImage imageNamed:@"cities.png"];

    Station *estacion=[[Station alloc]init];
    estacion= [self.arraForStation objectAtIndex:indexPath.row];
   
    //Add station to StationList
    [self.stationList addStation:station];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self performSegueWithIdentifier:@"stationsSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayerViewController * destinationViewController = segue.destinationViewController;
    
 //   NSLog(@"array con stations %@",[[self.arraForStation objectAtIndex:0]name ]);
    NSIndexPath * selectedRow = [self.tableView indexPathForSelectedRow];
     NSLog(@"seleciconada %@", selectedRow);
    destinationViewController.arraystationList=self.arraForStation;
    self.stationList.selectedStation = (int)selectedRow.row;
     NSLog(@"seleciconada %ld", (long)self.stationList.selectedStation);
   // NSLog(@"station%d,",self.stationList.selectedStation);
    destinationViewController.stationList = self.stationList;
    destinationViewController.arrayForFacebook=[NSMutableArray arrayWithArray:self.arraForStation];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    
    self.arraForStation=[[NSMutableArray alloc]init];
    self.stationList = [[StationList alloc] init];
    


     [self loadObjects];
}

-(void)viewWillDisappear:(BOOL)animated{
    
   // NSLog(@" estacion %@",self.stationList.stations);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
