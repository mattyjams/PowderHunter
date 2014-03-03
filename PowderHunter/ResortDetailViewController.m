//
//  ResortDetailViewController.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ResortDetailViewController.h"
#import "RTSpinKitView.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>

@interface ResortDetailViewController ()

-(void)populateView;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentHighLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hiderBox;
@property (weak, nonatomic) IBOutlet UILabel *twoDayTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseDepthLabel;
@property (weak, nonatomic) IBOutlet UILabel *snowConditionsLabel;

- (IBAction)onViewLocationOnMapButton:(UIButton *)sender;
@end

@implementation ResortDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.resort.name;

    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse color:[UIColor whiteColor]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Loading", @"Loading");
    
    [spinner startAnimating];
    
    [self.resort loadDetailsWithCallback:^(bool success) {
        [spinner stopAnimating];
        [hud hide:true];
        [self populateView];
    }];
}

-(void)populateView
{
    self.hiderBox.hidden = true;
    self.currentWeatherLabel.text = self.resort.currentConditions;
    self.currentLowLabel.text = [self.resort.currentLow stringValue];
    self.currentHighLabel.text = [self.resort.currentHigh stringValue];
    self.twoDayTotalLabel.text = [NSString stringWithFormat:@"%@\"", self.resort.twoDayTotal];
    self.baseDepthLabel.text = [NSString stringWithFormat:@"%@\"", self.resort.baseDepth];
    self.snowConditionsLabel.text = self.resort.currentSnow;
}

- (IBAction)onViewLocationOnMapButton:(UIButton *)sender
{
    MKMapView *mapView = [[MKMapView alloc] init];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.resort.coordinates, 50000, 50000);
    [mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.resort.coordinates;
    [mapView addAnnotation:annotation];

    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = mapView;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
