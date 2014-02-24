//
//  OpenSnowClient.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "OpenSnowClient.h"
#import <AFNetworking.h>
#import "Resort.h"

NSString * const OPENSNOW_BASE_URL = @"http://opensnow.com/api/";
NSString * const OPENSNOW_API_KEY = @"<apikey>";

@interface OpenSnowClient ()

@property (strong, nonatomic) NSString *apiKey;

@end

@implementation OpenSnowClient

+ (OpenSnowClient *)instance {
    static dispatch_once_t once;
    static OpenSnowClient *instance;
    
    dispatch_once(&once, ^{
        instance = [[OpenSnowClient alloc] initWithBaseURL:[NSURL URLWithString:OPENSNOW_BASE_URL]
                                                       key:OPENSNOW_API_KEY];
    });
    
    return instance;
}

- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key {
    self = [super initWithBaseURL:url];
    if (self != nil) {
        self.apiKey = key;
    }
    return self;
}

- (void)getLocationIdsWithState:(NSString *)state
                        success:(void (^)(NSURLSessionDataTask *task, NSArray *resorts))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (success == nil) {
        return;
    }

    NSString *getPath = @"getLocationIds.php";
    NSDictionary *params = @{@"apikey": self.apiKey,
                             @"type": @"json",
                             @"state": state};
    
    [self GET:getPath parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *resortsArray = nil;
        
        // The OpenSnow API is kind of broken. If you request locations for a state that
        // only has one location, the "location" key contains a dictionary. If there are
        // multiple locations, then it contains an array.
        id innerResponseObject = [responseObject objectForKey:@"location"];
        if ([innerResponseObject isKindOfClass:[NSArray class]]) {
            resortsArray = [Resort resortsWithArray:innerResponseObject];
        } else if ([innerResponseObject isKindOfClass:[NSDictionary class]]) {
            resortsArray = [Resort resortsWithArray:@[innerResponseObject]];
        }
        
        success(task, resortsArray);
    } failure:failure];
}

- (void)getLocationDataWithIds:(NSArray *)locationIds
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (success == nil) {
        return;
    }

    NSString *getPath = @"getLocationData.php";
    NSDictionary *params = @{@"apikey": self.apiKey,
                             @"type": @"json",
                             @"lids": [locationIds componentsJoinedByString:@","]};
    [self GET:getPath parameters:params success:success failure:failure];
}

@end
