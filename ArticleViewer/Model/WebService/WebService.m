//
//  WebService.m
//  ArticleViewer
//
//  Created by Aleksey on 6/19/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "WebService.h"

@implementation WebService

+ (instancetype)sharedService
{
    static WebService *sharedService = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedService = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://madiosgames.com/api/v1/"]];
    });
    
    return sharedService;
}

@end
