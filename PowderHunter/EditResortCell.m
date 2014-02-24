//
//  EditResortCell.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "EditResortCell.h"

@interface EditResortCell ()

@property (weak, nonatomic) IBOutlet UILabel *resortNameLabel;

@end

@implementation EditResortCell

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
}

- (void)setResort:(Resort *)resort
{
    _resort = resort;
    [self setup];
}

@end
