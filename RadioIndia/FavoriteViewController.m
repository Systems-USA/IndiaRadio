//
//  FavoriteViewController.m
//  RadioIndia
//
//  Created by SystemsUSA on 8/22/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "FavoriteViewController.h"
#import "StationCell.h"
#import "Station.h"
#import "StationList.h"
#import "PlayerViewController.h"

@interface FavoriteViewController ()


@end
NSMutableArray *arrayFavorite;
NSMutableDictionary *dicctionaryFavorite;

@implementation FavoriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arraForStation=[[NSMutableArray alloc]init];
    self.stationList = [[StationList alloc] init];
    
    // [self.arraForStation removeAllObjects];
    //[self.stationList.stations removeAllObjects];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    

    
    NSUserDefaults *savefavoritesArray=[NSUserDefaults standardUserDefaults];
    
    arrayFavorite = [NSMutableArray arrayWithArray:[savefavoritesArray objectForKey:@"favoriteArray"]];
    NSLog(@"array %@",arrayFavorite);
    if ([arrayFavorite count] !=0) {
        dicctionaryFavorite =[[NSMutableDictionary alloc]initWithDictionary:[arrayFavorite objectAtIndex:0]];
    }
    
    
    NSLog(@" FAVORITOS %@", dicctionaryFavorite);
    
}

-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Favorites";
        
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
    
   
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
    }
    
    [query orderByAscending:@"name"];
  /*  PFQuery *query = [PFQuery queryWithClassName:@"Favorites"];
    [query whereKey:@"name" equalTo:@""];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/
    [self.tableView reloadData];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    
    dicctionaryFavorite =[[NSMutableDictionary alloc]initWithDictionary:[arrayFavorite objectAtIndex:indexPath.row]];
    
    NSString *name= [dicctionaryFavorite objectForKey:@"name"];
    NSString *city =[dicctionaryFavorite objectForKey:@"city"];
    
    static NSString *CellIdentifier = @"FavoriteCell";
// NSLog(@"objetos %@",object);
    
    StationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Station* station = [[Station alloc] initWithName:[object objectForKey:@"name"] City:[object objectForKey:@"city"] Url:[object objectForKey:@"url"] Genre:[object objectForKey:@"genre"]];
    
    [self.arraForStation addObject:station];
    [self.stationList addStation:station];
  //  NSLog(@"estaciones %@", station);
    // Configure the cell

    cell.lblName.text = name;
    cell.lblCity.text = city;
    
    //cell.lblName.text=[[self.arraForStation objectAtIndex:indexPath.row] name];
    
    Station *estacion=[[Station alloc]init];
    estacion= [self.arraForStation objectAtIndex:indexPath.row];
    
    //Add station to StationList
    
    
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
    
    destinationViewController.arraystationList=self.arraForStation;
    
    self.stationList.selectedStation = (int)selectedRow.row;
    // NSLog(@"station%d,",self.stationList.selectedStation);
    destinationViewController.stationList = self.stationList;
    NSLog(@"aklsjdlkasj %@", self.stationList);
    
    destinationViewController.arrayForFacebook=[NSMutableArray arrayWithArray:self.arraForStation];
 //  NSLog(@"array %@", self.stationList);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        // After this, the playerName field will be empty
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            PFObject *object = [self.objects objectAtIndex:indexPath.row];
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self loadObjects];
            }];
            
             [self.stationList deleteStation:indexPath.row];
            [self.arraForStation removeObjectAtIndex:indexPath.row];
            [[self.stationList.stations objectAtIndex:indexPath.row]name];
        }
       
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [arrayFavorite count];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.arraForStation removeAllObjects];
    [self.stationList.stations removeAllObjects];
   // [self queryForTable];
   [self loadObjects];
    
    NSLog(@"imprimir estaciones arraforstation %@",self.arraForStation);
    NSLog(@"imrprimir stations %@", self.stationList.stations);
    
    
    NSUserDefaults *savefavoritesArray=[NSUserDefaults standardUserDefaults];
    
    arrayFavorite = [NSMutableArray arrayWithArray:[savefavoritesArray objectForKey:@"favoriteArray"]];
    NSLog(@"array %@",arrayFavorite);
    if ([arrayFavorite count] !=0) {
        dicctionaryFavorite =[[NSMutableDictionary alloc]initWithDictionary:[arrayFavorite objectAtIndex:0]];
    }
    
    
    NSLog(@" FAVORITOS %@", dicctionaryFavorite);
 
}

-(void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"imprimir estaciones arraforstation %@",self.arraForStation);
    NSLog(@"imrprimir stations %@", self.stationList.stations);
 //   [self.arraForStation removeAllObjects];
   // [self.stationList.stations removeAllObjects];
    
}

@end
