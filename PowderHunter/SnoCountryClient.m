//
//  SnoCountryClient.m
//  PowderHunter
//
//  Created by Matt Johnson on 2/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SnoCountryClient.h"
#import <AFNetworking.h>

NSString * const SNOCOUNTRY_BASE_URL = @"http://feeds.snocountry.com/";
NSString * const SNOCOUNRTY_API_KEY = @"SnoCountry.example";

@interface SnoCountryClient ()

@property (strong, nonatomic) NSString *apiKey;

@end

@implementation SnoCountryClient

+ (SnoCountryClient *)instance {
    static dispatch_once_t once;
    static SnoCountryClient *instance;
    
    dispatch_once(&once, ^{
        instance = [[SnoCountryClient alloc] initWithBaseURL:[NSURL URLWithString:SNOCOUNTRY_BASE_URL]
                                                         key:SNOCOUNRTY_API_KEY];
    });
    
    return instance;
}

- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key {
    self = [super initWithBaseURL:url];
    if (self != nil) {
        self.apiKey = key;
        
        // SnoCountry incorrectly returns the response with the content type "text/html"
        // even when the output is requested as json, so set the response serializer to accept
        // the bad content type
        NSMutableSet *contentTypes = [self.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObject:@"text/html"];
        self.responseSerializer.acceptableContentTypes = contentTypes;
    }
    return self;
}

- (void)getResortListWithStates:(NSArray *)states
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *getPath = @"getResortList.php";
    NSDictionary *params = @{@"apiKey": self.apiKey,
                             @"states": [states componentsJoinedByString:@","],
                             @"resortType":@"alpine",
                             @"output": @"json"};
    [self GET:getPath parameters:params success:success failure:failure];
}

- (void)getConditionsDetailWithResortId:(NSNumber *)resortId success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *getPath = @"conditions.php";
    NSDictionary *params = @{@"apiKey": self.apiKey,
                             @"ids": resortId,
                             @"output": @"json"};
    [self GET:getPath parameters:params success:success failure:failure];
}

@end
