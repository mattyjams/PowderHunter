//
//  FavoriteResortsManager.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FavoriteResortsManager.h"

static NSString *const FavoriteResortsUserDefaultsKey = @"favoriteResorts";

@implementation FavoriteResortsManager

+ (FavoriteResortsManager *)instance {
    static dispatch_once_t once;
    static FavoriteResortsManager *instance;
    
    dispatch_once(&once, ^{
        instance = [[FavoriteResortsManager alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.favoriteResorts = [self loadFavoriteResorts];
    }
    return self;
}

- (void)setFavoriteResorts:(NSMutableArray *)favoriteResorts
{
    _favoriteResorts = favoriteResorts;
    [self saveFavoriteResorts];
}

- (void)addFavoriteResort:(Resort *)resort
{
    if (![self isFavoriteResort:resort]) {
        [self.favoriteResorts addObject:resort];
        [self saveFavoriteResorts];
    }
}

- (void)insertFavoriteResort:(Resort *)resort atIndex:(NSInteger)index
{
    if (![self isFavoriteResort:resort]) {
        [self.favoriteResorts insertObject:resort atIndex:index];
        [self saveFavoriteResorts];
    }
}

- (void)removeFavoriteResort:(Resort *)resort
{
    for (Resort *favoriteResort in self.favoriteResorts) {
        if ([resort.openSnowID integerValue] == [favoriteResort.openSnowID integerValue]) {
            [self.favoriteResorts removeObject:favoriteResort];
            [self saveFavoriteResorts];
            break;
        }
    }
}

- (BOOL)isFavoriteResort:(Resort *)resort
{
    for (Resort *favoriteResort in self.favoriteResorts) {
        if ([resort.openSnowID integerValue] == [favoriteResort.openSnowID integerValue]) {
            return YES;
        }
    }
    return NO;
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

@end
