//
//  OpenSnowClient.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "OpenSnowClient.h"
#import <AFNetworking.h>

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

- (void)getLocationIdsForState:(NSString *)state
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *getPath = @"getLocationIds.php";
    NSDictionary *params = @{@"apikey": self.apiKey,
                             @"type": @"json",
                             @"state": state};
    [self GET:getPath parameters:params success:success failure:failure];
}

@end
