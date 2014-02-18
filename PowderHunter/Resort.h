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

+ (NSMutableArray *)resortsWithArray:(NSArray *)array;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
