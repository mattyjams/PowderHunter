//
//  Forecast.h
//  PowderHunter
//
//  Created by Matt Johnson on 3/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject

@property (strong, nonatomic) NSString *iconBaseURL;

@property (strong, nonatomic, readonly) NSDate *date;
@property (strong, nonatomic, readonly) NSString *dayOfWeek;

@property (strong, nonatomic, readonly) NSString *dayIcon;
@property (strong, nonatomic, readonly) NSNumber *daySnow;
@property (strong, nonatomic, readonly) NSNumber *dayTemp;
@property (strong, nonatomic, readonly) NSNumber *dayText;
@property (strong, nonatomic, readonly) NSNumber *dayWeather;

@property (strong, nonatomic, readonly) NSString *nightIcon;
@property (strong, nonatomic, readonly) NSNumber *nightSnow;
@property (strong, nonatomic, readonly) NSNumber *nightTemp;
@property (strong, nonatomic, readonly) NSNumber *nightText;
@property (strong, nonatomic, readonly) NSNumber *nightWeather;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
