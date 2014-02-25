//
//  FavoriteResortsManager.h
//  PowderHunter
//
//  Created by Matt Johnson on 2/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resort.h"

@interface FavoriteResortsManager : NSObject

@property (strong, nonatomic) NSMutableArray *favoriteResorts;

+ (FavoriteResortsManager *)instance;

- (void)addFavoriteResort:(Resort *)resort;
- (void)insertFavoriteResort:(Resort *)resort atIndex:(NSInteger)index;
- (void)removeFavoriteResort:(Resort *)resort;

- (BOOL)isFavoriteResort:(Resort *)resort;

@end
