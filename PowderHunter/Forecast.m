//
//  Forecast.m
//  PowderHunter
//
//  Created by Matt Johnson on 3/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Forecast.h"

@interface Forecast ()

@property (strong, nonatomic, readwrite) NSDate *date;
@property (strong, nonatomic, readwrite) NSString *dayOfWeek;

@property (strong, nonatomic, readwrite) NSString *dayIcon;
@property (strong, nonatomic, readwrite) NSNumber *daySnow;
@property (strong, nonatomic, readwrite) NSNumber *dayTemp;
@property (strong, nonatomic, readwrite) NSNumber *dayText;
@property (strong, nonatomic, readwrite) NSNumber *dayWeather;

@property (strong, nonatomic, readwrite) NSString *nightIcon;
@property (strong, nonatomic, readwrite) NSNumber *nightSnow;
@property (strong, nonatomic, readwrite) NSNumber *nightTemp;
@property (strong, nonatomic, readwrite) NSNumber *nightText;
@property (strong, nonatomic, readwrite) NSNumber *nightWeather;

@end

@implementation Forecast

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        id paramObject = [dict objectForKey:@"date"];
        if ([paramObject isKindOfClass:[NSString class]]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            self.date = [dateFormatter dateFromString:paramObject];
        }
        
        paramObject = [dict objectForKey:@"dow"];
        if ([paramObject isKindOfClass:[NSString class]]) {
            self.dayOfWeek = paramObject;
        }
        
        NSDictionary *dayDict = [dict objectForKey:@"day"];
        if (dayDict != nil) {
            paramObject = [dayDict objectForKey:@"icon"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.dayIcon = paramObject;
            }
            
            paramObject = [dayDict objectForKey:@"snow"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.daySnow = [NSNumber numberWithInt:[paramObject integerValue]];
            }
            
            paramObject = [dayDict objectForKey:@"temp"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.dayTemp = [NSNumber numberWithInt:[paramObject integerValue]];
            }
            
            paramObject = [dayDict objectForKey:@"text"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.dayText = paramObject;
            }
            
            paramObject = [dayDict objectForKey:@"weather"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.dayWeather = paramObject;
            }
        }
        
        NSDictionary *nightDict = [dict objectForKey:@"night"];
        if (nightDict != nil) {
            paramObject = [nightDict objectForKey:@"icon"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.nightIcon = paramObject;
            }
            
            paramObject = [nightDict objectForKey:@"snow"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.nightSnow = [NSNumber numberWithInt:[paramObject integerValue]];
            }
            
            paramObject = [nightDict objectForKey:@"temp"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.nightTemp = [NSNumber numberWithInt:[paramObject integerValue]];
            }
            
            paramObject = [nightDict objectForKey:@"text"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.nightText = paramObject;
            }
            
            paramObject = [nightDict objectForKey:@"weather"];
            if ([paramObject isKindOfClass:[NSString class]]) {
                self.nightWeather = paramObject;
            }
        }
    }
    return self;
}

@end
