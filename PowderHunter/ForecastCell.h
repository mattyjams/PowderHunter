//
//  ForecastCell.h
//  PowderHunter
//
//  Created by Matt Johnson on 3/4/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forecast.h"

@interface ForecastCell : UICollectionViewCell

@property (strong, nonatomic) Forecast *forecast;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *snowfallLabel;
@property (weak, nonatomic) IBOutlet UILabel *hiLoTempLabel;

@end
