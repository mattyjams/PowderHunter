//
//  ResortCell.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ResortCell.h"
#import <UIImageView+AFNetworking.h>

@interface ResortCell ()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *resortNameLabel;

@end

@implementation ResortCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.resortNameLabel.text = self.resort.name;
    
    [self.weatherImageView setImageWithURL:[NSURL URLWithString:self.resort.currentWeatherIcon]];
}

- (void)setResort:(Resort *)resort
{
    _resort = resort;
    [self setup];
}

@end
