//
//  ResortCell.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ResortCell.h"

@interface ResortCell ()

@property (weak, nonatomic) IBOutlet UILabel *resortNameLabel;

@end

@implementation ResortCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setResort:(Resort *)resort
{
    self.resortNameLabel.text = resort.name;
}

@end
