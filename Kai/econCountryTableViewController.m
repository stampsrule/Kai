//
//  econCountryTableViewController.m
//  Kai
//
//  Created by Daniel Bell on 2014-03-10.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econCountryTableViewController.h"
#import "econCountryTableViewCell.h"
#import "econCountryViewController.h"
#import "econAppDelegate.h"
#import "CountryName.h"
#import "NominalGDPData.h"
#import "M1Data.h"
#import "M2Data.h"
#import "RealGDPData.h"
@interface econCountryTableViewController ()

@property (nonatomic,strong)NSArray* fetchedCountriesArray;

@end

@implementation econCountryTableViewController
@synthesize delegate;

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
    self.clearsSelectionOnViewWillAppear = NO;
    econAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedCountriesArray = [appDelegate getAllCountryData];
    [self.tableView reloadData];


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedCountriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Country table cell";
    
    econCountryTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    CountryName *countryRecord=[self.fetchedCountriesArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    //1
    M2Data* m2object= (M2Data *)countryRecord.countryM2;
    RealGDPData* realGDPObject= (RealGDPData*)countryRecord.countryRealGDP;
    //2
    cell.moneyLabel.text = [[NSNumber numberWithDouble:[m2object.current doubleValue]/1000000000] stringValue];
    cell.incomeLabel.text = [[NSNumber numberWithDouble:[realGDPObject.current doubleValue]/1000000000] stringValue];
    cell.countryLabel.text = countryRecord.name;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Money Supply | real GDP";
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    CountryName *countryRecord=[self.fetchedCountriesArray objectAtIndex:myIndexPath.row];
    M2Data* m2object= (M2Data *)countryRecord.countryM2;
    RealGDPData* realGDPObject= (RealGDPData*)countryRecord.countryRealGDP;

    
    if ([segue.identifier isEqualToString:@"Save Selected Country"]) {
        if ([segue.destinationViewController isKindOfClass:[econCountryViewController class]]) {
            econCountryViewController *ecvc = (econCountryViewController *)segue.destinationViewController;
            ecvc.strCountryName=countryRecord.name;
            ecvc.strPassedMoneySupplyValue=[[NSNumber numberWithDouble:[m2object.current doubleValue]/1000000000] stringValue];
            ecvc.strPassedIncomeValue =[[NSNumber numberWithDouble:[realGDPObject.current doubleValue]/1000000000] stringValue];
            ecvc.delegate=self.delegate[0];
        }
    }
 
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
