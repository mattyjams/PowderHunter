//
//  Temperature.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Temperature.h"

static NSString *const TemperatureCoderKey = @"temperature";

@interface Temperature ()

// temperatures are stored internally as degrees fahrenheit
@property (strong, nonatomic) NSNumber *temperature;

@end

@implementation Temperature

@dynamic degreesFahrenheit;
@dynamic degreesCelsius;

+ (NSNumber *)convertDegreesFahrenheitToCelsius:(NSNumber *)degreesFahrenheit {
    double degreesCelsius = (([degreesFahrenheit doubleValue] - 32.0) * (5.0 / 9.0));
    return [NSNumber numberWithDouble:degreesCelsius];
}

+ (NSNumber *)convertDegreesCelsiusToFahrenheit:(NSNumber *)degreesCelsius {
    double degreesFahrenheit = (([degreesCelsius doubleValue] * (9.0 / 5.0)) + 32.0);
    return [NSNumber numberWithDouble:degreesFahrenheit];
}

+ (id)temperatureWithDegreesFahrenheit:(NSNumber *)degreesFahrenheit
{
    return [[Temperature alloc] initWithDegreesFahrenheit:degreesFahrenheit];
}

+ (id)temperatureWithDegreesCelsius:(NSNumber *)degreesCelsius
{
    return [[Temperature alloc] initWithDegreesCelcius:degreesCelsius];
}

- (id)initWithDegreesFahrenheit:(NSNumber *)degreesFahrenheit
{
    self = [super init];
    if (self) {
        self.temperature = degreesFahrenheit;
    }
    return self;
}

- (id)initWithDegreesCelcius:(NSNumber *)degreesCelsius
{
    self = [super init];
    if (self) {
        self.temperature = [Temperature convertDegreesCelsiusToFahrenheit:degreesCelsius];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.temperature = [aDecoder decodeObjectForKey:TemperatureCoderKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.temperature forKey:TemperatureCoderKey];
}

- (NSNumber *)degreesFahrenheit
{
    return self.temperature;
}

- (void)setDegreesFahrenheit:(NSNumber *)degreesFahrenheit
{
    self.temperature = degreesFahrenheit;
}

- (NSNumber *)degreesCelsius
{
    return [Temperature convertDegreesFahrenheitToCelsius:self.temperature];
}

- (void)setDegreesCelsius:(NSNumber *)degreesCelsius
{
    self.temperature = [Temperature convertDegreesCelsiusToFahrenheit:degreesCelsius];
}

@end
