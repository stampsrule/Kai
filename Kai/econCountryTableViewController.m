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
@interface econCountryTableViewController ()

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


        _countryName = @[@"USA",
                      @"Canada",
                      @"China",
                      @"New Zealand",
                      @"Australia"];
        
        _countryMoneySupply = @[@"11011.60",
                       @"1800.31900",
                       @"113180.00",
                       @"269.13600",
                       @"1617.75400"];
    
        _countryIncome = @[@"15932.90",
                       @"1712.00100",
                       @"8230.00",
                       @"38.57500",
                       @"390.57200"];
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
    return _countryName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Country table cell";
    
    econCountryTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    
    // Configure the cell...

    long row = [indexPath row];
    cell.moneyLabel.text = _countryMoneySupply[row];
    cell.incomeLabel.text = _countryIncome[row];
    cell.countryLabel.text = _countryName[row];
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
    return @"Money Supply (M2 or M3) | GDP in constant dollars";
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    long row = [myIndexPath row];
    
    if ([segue.identifier isEqualToString:@"Save Selected Country"]) {
        if ([segue.destinationViewController isKindOfClass:[econCountryViewController class]]) {
            econCountryViewController *ecvc = (econCountryViewController *)segue.destinationViewController;
            ecvc.strCountryName=_countryName[row];
            ecvc.strPassedMoneySupplyValue=_countryMoneySupply[row];
            ecvc.strPassedIncomeValue =_countryIncome[row];
            ecvc.delegate=self.delegate[0];
        }
    }
 
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
