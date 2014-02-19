//
//  ResortsViewController.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ResortsViewController.h"
#import "OpenSnowClient.h"
#import "SnoCountryClient.h"
#import "Resort.h"
#import "ResortCell.h"
#import "ResortDetailViewController.h"

static NSString *ResortCellIdentifier = @"ResortCell";

@interface ResortsViewController ()

@property (strong, nonatomic) NSArray *resorts; // of Resort

@end

@implementation ResortsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadResorts];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self loadResorts];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Resorts";
    
    UINib *resortCellNib = [UINib nibWithNibName:ResortCellIdentifier bundle:nil];
    [self.tableView registerNib:resortCellNib forCellReuseIdentifier:ResortCellIdentifier];
}

- (void)loadResorts
{
    [[OpenSnowClient instance] getLocationIdsWithState:@"CA"
                                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                                   self.resorts = [Resort resortsWithArray:[responseObject valueForKey:@"location"]];
                                                   [self.tableView reloadData];
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   NSLog(@"error: %@", error);
                                               }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resorts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResortCell *cell = [tableView dequeueReusableCellWithIdentifier:ResortCellIdentifier
                                                       forIndexPath:indexPath];
    cell.resort = self.resorts[indexPath.row];

    return cell;
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResortDetailViewController *resortVC = [[ResortDetailViewController alloc] init];
    resortVC.resort = self.resorts[indexPath.row];
    [self.navigationController pushViewController:resortVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
