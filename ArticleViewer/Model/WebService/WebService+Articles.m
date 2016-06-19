//
//  WebService+Articles.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "WebService+Articles.h"

static NSString *urlString = @"application/ios_test_task/articles";

@implementation WebService (Articles)

- (void)getArticlesWithBlock:(completionBlock)block
{
    [self GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"In process..");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success!");
        block(nil, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error!");
        block(error, nil, nil);
    }];
}

@end
