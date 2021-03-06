//
//  OpenSnowClient.h
//  PowderHunter
//
//  Created by Matt Johnson on 2/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface OpenSnowClient : AFHTTPSessionManager

+ (OpenSnowClient *)instance;

- (void)getLocationIdsWithState:(NSString *)state
                        success:(void (^)(NSURLSessionDataTask *task, NSArray *resorts))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getLocationDataWithIds:(NSArray *)locationIds
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
