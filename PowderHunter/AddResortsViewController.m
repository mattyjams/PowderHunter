//
//  AddResortsViewController.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "AddResortsViewController.h"
#import "EditResortCell.h"
#import "OpenSnowClient.h"

static NSString *EditResortCellIdentifier = @"EditResortCell";

@interface AddResortsViewController () <UIPickerViewDelegate, UIPickerViewDataSource,
                                        UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UITableView *resortTableView;

@property (strong, nonatomic) NSMutableArray *resortChoices;

@end

@implementation AddResortsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *resortCellNib = [UINib nibWithNibName:EditResortCellIdentifier bundle:nil];
    [self.resortTableView registerNib:resortCellNib forCellReuseIdentifier:EditResortCellIdentifier];
    
    self.title = @"Add Resorts";
    
    self.statePicker.delegate = self;
    self.statePicker.dataSource = self;
    
    self.resortTableView.delegate = self;
    self.resortTableView.dataSource = self;
}

#pragma Mark - Picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self StateNames][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [[OpenSnowClient instance] getLocationIdsWithState:[self StateCodes][row]
                                               success:^(NSURLSessionDataTask *task, NSArray *resorts) {
                                                   self.resortChoices = [resorts mutableCopy];
                                                   [self.resortTableView reloadData];
                                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   NSLog(@"error: %@", error);
                                               }];
}

#pragma Mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self StateNames].count;
}

#pragma Mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditResortCell *cell = [tableView dequeueReusableCellWithIdentifier:EditResortCellIdentifier
                                                           forIndexPath:indexPath];
    cell.resort = self.resortChoices[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected resort: %@", self.resortChoices[indexPath.row]);
}

#pragma Mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resortChoices.count;
}

- (NSArray *)StateNames
{
    return @[@"Select a state",
             @"Alabama",
             @"Alaska",
             @"Arizona",
             @"Arkansas",
             @"California",
             @"Colorado",
             @"Connecticut",
             @"Delaware",
             @"Florida",
             @"Georgia",
             @"Hawaii",
             @"Idaho",
             @"Illinois",
             @"Indiana",
             @"Iowa",
             @"Kansas",
             @"Kentucky",
             @"Louisiana",
             @"Maine",
             @"Maryland",
             @"Massachusetts",
             @"Michigan",
             @"Minnesota",
             @"Mississippi",
             @"Missouri",
             @"Montana",
             @"Nebraska",
             @"Nevada",
             @"New Hampshire",
             @"New Jersey",
             @"New Mexico",
             @"New York",
             @"North Carolina",
             @"North Dakota",
             @"Ohio",
             @"Oklahoma",
             @"Oregon",
             @"Pennsylvania",
             @"Rhode Island",
             @"South Carolina",
             @"South Dakota",
             @"Tennessee",
             @"Texas",
             @"Utah",
             @"Vermont",
             @"Virginia",
             @"Washington",
             @"West Virginia",
             @"Wisconsin",
             @"Wyoming"];
}

- (NSArray *)StateCodes
{
    return @[@"",
             @"AL",
             @"AK",
             @"AZ",
             @"AR",
             @"CA",
             @"CO",
             @"CT",
             @"DE",
             @"FL",
             @"GA",
             @"HI",
             @"ID",
             @"IL",
             @"IN",
             @"IA",
             @"KS",
             @"KY",
             @"LA",
             @"ME",
             @"MD",
             @"MA",
             @"MI",
             @"MN",
             @"MS",
             @"MO",
             @"MT",
             @"NE",
             @"NV",
             @"NH",
             @"NJ",
             @"NM",
             @"NY",
             @"NC",
             @"ND",
             @"OH",
             @"OK",
             @"OR",
             @"PA",
             @"RI",
             @"SC",
             @"SD",
             @"TN",
             @"TX",
             @"UT",
             @"VT",
             @"VA",
             @"WA",
             @"WV",
             @"WI",
             @"WY"];
}

@end
