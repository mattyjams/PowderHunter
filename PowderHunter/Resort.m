//
//  Resort.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Resort.h"
#import "SnoCountryClient.h"

static NSString *const OpenSnowIDCoderKey = @"openSnowID";
static NSString *const SnoCountryIDCoderKey = @"snoCountryID";
static NSString *const NameCoderKey = @"name";

@interface Resort ()

@property (strong, nonatomic, readwrite) NSNumber *openSnowID;
@property (strong, nonatomic, readwrite) NSNumber *snoCountryID;

@property (strong, nonatomic, readwrite) NSString *name;

@property (nonatomic, readwrite) BOOL loadedDetail;

@property (strong, nonatomic, readwrite) NSString *currentConditions;
@property (strong, nonatomic, readwrite) NSNumber *currentLow;
@property (strong, nonatomic, readwrite) NSNumber *currentHigh;
@property (strong, nonatomic, readwrite) NSNumber *twoDayTotal;
@property (strong, nonatomic, readwrite) NSNumber *baseDepth;
@property (strong, nonatomic, readwrite) NSString *currentSnow;

@end

@implementation Resort

+ (NSArray *)resortsWithArray:(NSArray *)array
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
        self.loadedDetail = NO;

        id paramObject = [dict objectForKey:@"name"];
        if ([paramObject isKindOfClass:[NSString class]]) {
            self.name = paramObject;
        }
        
        paramObject = [dict objectForKey:@"id"];
        if ([paramObject isKindOfClass:[NSString class]]) {
            self.openSnowID = [NSNumber numberWithInt:[paramObject integerValue]];
        }
        
        paramObject = [dict objectForKey:@"snowid"];
        if ([paramObject isKindOfClass:[NSString class]]) {
            self.snoCountryID = [NSNumber numberWithInt:[paramObject integerValue]];
        }
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

- (void) loadDetailsWithCallback:(void(^)(bool success)) callback
{
    if (self.loadedDetail == false) {
        // would probably be best to batch all these calls ...
        [[SnoCountryClient instance] getConditionsDetailWithResortId:self.snoCountryID
                                    success: ^(NSURLSessionDataTask *task, id responseObject) {
                                        sleep(2);
                                        NSArray* arr = [responseObject objectForKey:@"items"];
                                        // only wanted 1 resort, so current resort is in slot 0
                                        NSDictionary *resortDetail = arr[0];
                                        self.currentConditions = [resortDetail objectForKey:@"weatherToday_Condition"];
                                        self.currentLow = [NSNumber numberWithInt:[[resortDetail objectForKey:@"weatherToday_Temperature_Low"] integerValue]];
                                        self.currentHigh = [NSNumber numberWithInt:[[resortDetail objectForKey:@"weatherToday_Temperature_High"] integerValue]];
                                        self.currentSnow = [resortDetail objectForKey:@"primarySurfaceCondition"];
                                        self.twoDayTotal = [NSNumber numberWithInt:[[resortDetail objectForKey:@"snowLast48Hours"] integerValue]];
                                        self.baseDepth = [NSNumber numberWithInt:[[resortDetail objectForKey:@"avgBaseDepthMax"] integerValue]];
                                        
                                        
                                        self.loadedDetail = true;
                                        if(callback) {
                                            callback(true);
                                        }
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Error with resort %@", self.name);
                                        if(callback) {
                                            callback(false);
                                        }
                                    }];
    } else {
        if (callback) {
            callback(true);
        }
    }
}

@end
