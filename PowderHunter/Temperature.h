//
//  Temperature.h
//  PowderHunter
//
//  Created by Matt Johnson on 2/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temperature : NSObject <NSCoding>

@property (nonatomic) NSNumber *degreesFahrenheit;
@property (nonatomic) NSNumber *degreesCelsius;

+ (NSNumber *)convertDegreesFahrenheitToCelsius:(NSNumber *)degreesFahrenheit;
+ (NSNumber *)convertDegreesCelsiusToFahrenheit:(NSNumber *)degreesCelsius;

+ (id)temperatureWithDegreesFahrenheit:(NSNumber *)degreesFahrenheit;
+ (id)temperatureWithDegreesCelsius:(NSNumber *)degreesCelsius;

- (id)initWithDegreesFahrenheit:(NSNumber *)degreesFahrenheit;
- (id)initWithDegreesCelcius:(NSNumber *)degreesCelsius;

@end
