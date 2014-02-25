//
//  EditResortCell.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "EditResortCell.h"
#import "FavoriteResortsManager.h"

@interface EditResortCell ()

@property (weak, nonatomic) IBOutlet UILabel *resortNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

- (IBAction)onFavoriteButtonTapped:(UIButton *)sender;

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
    
    if ([[FavoriteResortsManager instance] isFavoriteResort:self.resort]) {
        self.favoriteButton.selected = YES;
    } else {
        self.favoriteButton.selected = NO;
    }
}

- (void)setResort:(Resort *)resort
{
    _resort = resort;
    [self setup];
}

- (IBAction)onFavoriteButtonTapped:(UIButton *)sender
{
    if ([[FavoriteResortsManager instance] isFavoriteResort:self.resort]) {
        [[FavoriteResortsManager instance] removeFavoriteResort:self.resort];
    } else {
        [[FavoriteResortsManager instance] addFavoriteResort:self.resort];
    }
    self.favoriteButton.selected = !self.favoriteButton.selected;
}
@end
