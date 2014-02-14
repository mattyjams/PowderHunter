//
//  SnoCountryClient.h
//  PowderHunter
//
//  Created by Matt Johnson on 2/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface SnoCountryClient : AFHTTPSessionManager

+ (SnoCountryClient *)instance;

- (void)getResortListWithStates:(NSArray *)states
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
