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

@interface ResortsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *resortsTableView;
@property (weak, nonatomic) IBOutlet UIView *welcomeView;

@end

@implementation ResortsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Resorts";
    
    UINib *resortCellNib = [UINib nibWithNibName:ResortCellIdentifier bundle:nil];
    [self.resortsTableView registerNib:resortCellNib forCellReuseIdentifier:ResortCellIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(onAddButton)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configureViews];
    [self.resortsTableView reloadData];
    
    [self updateDataForResorts];
}

- (void)configureViews
{
    if ([[FavoriteResortsManager instance].favoriteResorts count] > 0) {
        self.welcomeView.hidden = true;
        self.resortsTableView.hidden = false;

        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    } else {
        self.welcomeView.hidden = false;
        self.resortsTableView.hidden = true;

        self.navigationItem.leftBarButtonItem = nil;
        [self setEditing:NO animated:YES];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.resortsTableView setEditing:editing animated:animated];
}

- (void)updateDataForResorts
{
    NSArray *resorts = [FavoriteResortsManager instance].favoriteResorts;
    for (Resort *resort in resorts) {
        [resort loadForecastDataWithCallback:^(BOOL success) {
            [self.resortsTableView reloadData];
        }];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Resort *resort = [FavoriteResortsManager instance].favoriteResorts[indexPath.row];
        [[FavoriteResortsManager instance] removeFavoriteResort:resort];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self configureViews];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Resort *resort = [FavoriteResortsManager instance].favoriteResorts[fromIndexPath.row];
    [[FavoriteResortsManager instance] removeFavoriteResort:resort];
    [[FavoriteResortsManager instance] insertFavoriteResort:resort atIndex:toIndexPath.row];
    
    [self.resortsTableView reloadData];
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
