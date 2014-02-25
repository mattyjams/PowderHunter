//
//  ResortsViewController.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ResortsViewController.h"
#import "OpenSnowClient.h"
#import "Resort.h"
#import "ResortCell.h"
#import "FavoriteResortsManager.h"
#import "ResortDetailViewController.h"
#import "AddResortsViewController.h"

static NSString *ResortCellIdentifier = @"ResortCell";

@implementation ResortsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Resorts";
    
    UINib *resortCellNib = [UINib nibWithNibName:ResortCellIdentifier bundle:nil];
    [self.tableView registerNib:resortCellNib forCellReuseIdentifier:ResortCellIdentifier];
    
    [self updateDataForResorts:[FavoriteResortsManager instance].favoriteResorts];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(onAddButton)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)updateDataForResorts:(NSArray *)resorts
{
    NSMutableArray *resortIds = [NSMutableArray arrayWithCapacity:[resorts count]];
    for (Resort *resort in resorts) {
        [resortIds addObject:resort.openSnowID];
    }
    
    [[OpenSnowClient instance] getLocationDataWithIds:resortIds
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  NSLog(@"responseObject: %@", responseObject);
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  NSLog(@"error: %@", error);
                                              }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[FavoriteResortsManager instance].favoriteResorts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResortCell *cell = [tableView dequeueReusableCellWithIdentifier:ResortCellIdentifier
                                                       forIndexPath:indexPath];
    cell.resort = [FavoriteResortsManager instance].favoriteResorts[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Resort *resort = [FavoriteResortsManager instance].favoriteResorts[indexPath.row];
        [[FavoriteResortsManager instance] removeFavoriteResort:resort];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Resort *resort = [FavoriteResortsManager instance].favoriteResorts[fromIndexPath.row];
    [[FavoriteResortsManager instance] removeFavoriteResort:resort];
    [[FavoriteResortsManager instance] insertFavoriteResort:resort atIndex:toIndexPath.row];
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResortDetailViewController *resortVC = [[ResortDetailViewController alloc] init];
    resortVC.resort = [FavoriteResortsManager instance].favoriteResorts[indexPath.row];
    [self.navigationController pushViewController:resortVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onAddButton {
    AddResortsViewController *addVC = [[AddResortsViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
