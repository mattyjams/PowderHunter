//
//  Resort.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Resort.h"

static NSString *const OpenSnowIDCoderKey = @"openSnowID";
static NSString *const SnoCountryIDCoderKey = @"snoCountryID";
static NSString *const NameCoderKey = @"name";

@interface Resort ()

@property (strong, nonatomic, readwrite) NSNumber *openSnowID;
@property (strong, nonatomic, readwrite) NSNumber *snoCountryID;

@property (strong, nonatomic, readwrite) NSString *name;

@end

@implementation Resort

+ (NSMutableArray *)resortsWithArray:(NSArray *)array
{
    NSMutableArray *resorts = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [resorts addObject:[[Resort alloc] initWithDictionary:params]];
    }
    return resorts;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        
        NSString *idString = [dict objectForKey:@"id"];
        self.openSnowID = [NSNumber numberWithInt:[idString integerValue]];

        idString = [dict objectForKey:@"snowid"];
        self.snoCountryID = [NSNumber numberWithInt:[idString integerValue]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.openSnowID = [aDecoder decodeObjectForKey:OpenSnowIDCoderKey];
        self.snoCountryID = [aDecoder decodeObjectForKey:SnoCountryIDCoderKey];
        self.name = [aDecoder decodeObjectForKey:NameCoderKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.openSnowID forKey:OpenSnowIDCoderKey];
    [aCoder encodeObject:self.snoCountryID forKey:SnoCountryIDCoderKey];
    [aCoder encodeObject:self.name forKey:NameCoderKey];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Resort Name: %@ (OpenSnowID: %@, SnoCountryID: %@)",
            self.name, self.openSnowID, self.snoCountryID];
}

@end
