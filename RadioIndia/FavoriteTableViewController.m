//
//  FavoriteTableViewController.m
//  RadioIndia
//
//  Created by SystemsUSA on 9/2/14.
//  Copyright (c) 2014 Systems USA. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "StationCell.h"
#import "Station.h"

#import "PlayerViewController.h"


@interface FavoriteTableViewController ()

@end

NSMutableArray *arrayFavorite;
NSMutableDictionary *dicctionaryFavorite;
int contadorRealoadTable;

@implementation FavoriteTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    NSUserDefaults *savefavoritesArray=[NSUserDefaults standardUserDefaults];
    
    arrayFavorite = [NSMutableArray arrayWithArray:[savefavoritesArray objectForKey:@"favoriteArray"]];
    
    self.arraForStation=[[NSMutableArray alloc]init];
    self.stationList = [[StationList alloc] init];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [arrayFavorite count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    dicctionaryFavorite =[[NSMutableDictionary alloc]initWithDictionary:[arrayFavorite objectAtIndex:indexPath.row]];
    
    NSString *name= [dicctionaryFavorite objectForKey:@"name"];
    NSString *city =[dicctionaryFavorite objectForKey:@"city"];
    
    static NSString *CellIdentifier = @"FavoriteCell";
    NSLog(@"dicctionaryFavorite %@",dicctionaryFavorite);
    
    StationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    Station* station = [[Station alloc] initWithName:[dicctionaryFavorite objectForKey:@"name"] City:[dicctionaryFavorite objectForKey:@"city"] Url:[dicctionaryFavorite objectForKey:@"url"] Genre:[dicctionaryFavorite objectForKey:@"genre"]];
    
    
    //if (contadorRealoadTable==0) {
         [self.stationList addStation:station];
  //  }
    [self.arraForStation addObject:station];
   
    
    cell.lblName.text=name;
    cell.lblCity.text=city;
    
    
    Station *estacion=[[Station alloc]init];
    estacion= [self.arraForStation objectAtIndex:indexPath.row];
    
    //Add station to StationList
  //  [self.stationList addStation:station];
    
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
    // NSLog(@"station%d,",self.stationList.selectedStation);
    destinationViewController.stationList = self.stationList;
    destinationViewController.arrayForFacebook=[NSMutableArray arrayWithArray:self.arraForStation];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 76;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
  // NSUserDefaults *savefavoritesArray=[NSUserDefaults standardUserDefaults];
 
  //  arrayFavorite = [NSMutableArray arrayWithArray:[savefavoritesArray objectForKey:@"favoriteArray"]];
// NSLog(@"array %@",arrayFavorite);
// [self.stationList.stations removeAllObjects];
NSLog(@"imrprimir stations %@", self.stationList.stations);
//   [self.tableView reloadData];
//    NSLog(@"imrprimir stations %@", self.stationList.stations);
   // NSLog(@" FAVORITOS %@", dicctionaryFavorite);
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            NSUserDefaults *deleteUserDefault =[NSUserDefaults standardUserDefaults];
            
          //  [self.stationList deleteStation:indexPath.row];
          [self.stationList deleteStation:indexPath.row];
            
            [self.arraForStation removeAllObjects];
            
            [arrayFavorite removeObjectAtIndex:indexPath.row];
            NSLog(@"imrpimer array %@",arrayFavorite);
            
            [deleteUserDefault setObject:arrayFavorite forKey:@"favoriteArray"];
            [deleteUserDefault synchronize];
            
             arrayFavorite = [NSMutableArray arrayWithArray:[deleteUserDefault objectForKey:@"favoriteArray"]];
            
            NSLog(@"imrpimer array %@",arrayFavorite);
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            contadorRealoadTable=1;
           [tableView reloadData];
            
        
        }
        
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
