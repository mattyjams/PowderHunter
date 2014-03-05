//
//  ForecastCell.m
//  PowderHunter
//
//  Created by Matt Johnson on 3/4/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ForecastCell.h"
#import <UIImageView+AFNetworking.h>

@implementation ForecastCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)setForecast:(Forecast *)forecast
{
    _forecast = forecast;
    [self configureViews];
}

- (void)configureViews
{
    self.dayLabel.text = self.forecast.dayOfWeek;
    [self.weatherImageView setImageWithURL:[NSURL URLWithString:self.forecast.dayIcon]];
    self.snowfallLabel.text = [NSString stringWithFormat:@"%@\"", [self.forecast.daySnow stringValue]];
    self.hiLoTempLabel.text = [NSString stringWithFormat:@"%@º/%@º",
                               [self.forecast.dayTemp stringValue],
                               [self.forecast.nightTemp stringValue]];
}

@end
