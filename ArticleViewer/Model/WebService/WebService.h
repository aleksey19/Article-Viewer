//
//  WebService.h
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^completionBlock)(NSError *error, NSDictionary *dicticionary, NSArray *array);

@interface WebService : AFHTTPSessionManager

+ (instancetype)sharedService;

@end
