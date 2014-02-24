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
#import "AddResortsViewController.h"

static NSString *ResortCellIdentifier = @"ResortCell";

static NSString *const FavoriteResortsUserDefaultsKey = @"favoriteResorts";

@interface ResortsViewController ()

@property (strong, nonatomic) NSMutableArray *favoriteResorts; // of Resort

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
    
    self.favoriteResorts = [self loadFavoriteResorts];
    [self updateDataForResorts:self.favoriteResorts];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(onAddButton)];
}

- (NSMutableArray *)loadFavoriteResorts
{
    NSMutableArray *array;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:FavoriteResortsUserDefaultsKey];
    if (data != nil)
    {
        array = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    
    if (array == nil)
    {
        array = [[NSMutableArray alloc] init];
    }
    
    return array;
}

- (void)saveFavoriteResorts
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.favoriteResorts];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:FavoriteResortsUserDefaultsKey];
    [defaults synchronize];
}

- (void)loadResorts
{
    [[OpenSnowClient instance] getLocationIdsWithState:@"CA"
                                               success:^(NSURLSessionDataTask *task, NSArray *resorts) {
                                                   self.favoriteResorts = [resorts mutableCopy];
                                                   [self.tableView reloadData];
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   NSLog(@"error: %@", error);
                                               }];
}

- (void)updateDataForResorts:(NSArray *)resorts
{
    NSMutableArray *resortIds = [NSMutableArray arrayWithCapacity:resorts.count];
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
    return self.favoriteResorts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResortCell *cell = [tableView dequeueReusableCellWithIdentifier:ResortCellIdentifier
                                                       forIndexPath:indexPath];
    cell.resort = self.favoriteResorts[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.favoriteResorts removeObjectAtIndex:indexPath.row];
        [self saveFavoriteResorts];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Resort *resort = self.favoriteResorts[fromIndexPath.row];
    [self.favoriteResorts removeObjectAtIndex:fromIndexPath.row];
    [self.favoriteResorts insertObject:resort atIndex:toIndexPath.row];
    [self saveFavoriteResorts];
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResortDetailViewController *resortVC = [[ResortDetailViewController alloc] init];
    resortVC.resort = self.favoriteResorts[indexPath.row];
    [self.navigationController pushViewController:resortVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onAddButton {
    AddResortsViewController *addVC = [[AddResortsViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
