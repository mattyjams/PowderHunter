//
//  Resort.h
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resort : NSObject <NSCoding>

@property (strong, nonatomic, readonly) NSNumber *openSnowID;
@property (strong, nonatomic, readonly) NSNumber *snoCountryID;

@property (strong, nonatomic, readonly) NSString *name;

@property (strong, nonatomic, readonly) NSString *currentConditions;
@property (strong, nonatomic, readonly) NSNumber *currentLow;
@property (strong, nonatomic, readonly) NSNumber *currentHigh;
@property (strong, nonatomic, readonly) NSNumber *twoDayTotal;
@property (strong, nonatomic, readonly) NSNumber *baseDepth;
@property (strong, nonatomic, readonly) NSString *currentSnow;

+ (NSArray *)resortsWithArray:(NSArray *)array;

- (id)initWithDictionary:(NSDictionary *)dict;

- (void) loadDetailsWithCallback:(void(^)(bool success)) callback;

@end
